#!/usr/bin/env python

import sys, os, json, time, secrets
from datetime import datetime, timezone
import requests


class Graylog:

	BASEURL = 'http://graylog.logging.svc.cluster.local:9000/api'
	DATA_PATH = '/graylog'
	REQ_ARGS = {
		'timeout': (5, 10),	# 5 sec connection timeout, 10 sec timeout to receive data
		'auth': ('admin', os.environ.get('ADMIN_PASSWD')),
		'headers': {
			# 'Content-Type': 'application/json; charset=UTF-8',
			'X-Requested-By': 'provisioner'
		}
	}

	class Config:
		ssoHeader = {
			"username_header": "X-Username",
			"enabled": True
		}
		ssoUser = {
			"first_name": "Operator",
			"last_name": "Graylog",
			"username": "operator",
			"email": "operator@cloud.esa-worldcereal.org",
			"password": secrets.token_urlsafe(32),
			"roles": ["Admin"],
			"permissions": []
		}

		staticField = 'input_src'

		inputs = {
			'system-hosts': {
				"title": "System Logs (Nodes)",
				"type": "org.graylog2.inputs.syslog.udp.SyslogUDPInput",
				"global": True,
				"configuration": {
					"expand_structured_data": False,
					"recv_buffer_size": 2621440,
					"port": 30514,
					"number_worker_threads": 4,
					"force_rdns": False,
					"allow_override_date": True,
					"bind_address": "0.0.0.0",
					"store_full_message": False
				}
			},
			'system-k8s': {
				"title": "System Logs (Pods)",
				"type": "org.graylog2.inputs.syslog.udp.SyslogUDPInput",
				"global": True,
				"configuration": {
					"expand_structured_data": False,
					"recv_buffer_size": 2621440,
					"port": 31514,
					"number_worker_threads": 4,
					"force_rdns": False,
					"allow_override_date": True,
					"bind_address": "0.0.0.0",
					"store_full_message": False
				}
			},
			'ewoc': {
				"title": "Processing Logs",
				"type": "org.graylog2.inputs.syslog.udp.SyslogUDPInput",
				"global": True,
				"configuration": {
					"expand_structured_data": False,
					"recv_buffer_size": 2621440,
					"port": 32514,
					"number_worker_threads": 8,
					"force_rdns": False,
					"allow_override_date": True,
					"bind_address": "0.0.0.0",
					"store_full_message": False
				}
			}
		}

		# Dict keys will be used as "index_prefix"
		indices = {
			'system': {
				"title": "System Logs",
				"description": "System Logs",
				# "index_prefix": "system",
				"shards": 3,
				"replicas": 2,
				"can_be_default": True,
				"rotation_strategy_class": "org.graylog2.indexer.rotation.strategies.SizeBasedRotationStrategy",
				"rotation_strategy": {
					"type": "org.graylog2.indexer.rotation.strategies.SizeBasedRotationStrategyConfig",
					"max_size": 1073741824
				},
				"retention_strategy_class": "org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy",
				"retention_strategy": {
					"type": "org.graylog2.indexer.retention.strategies.DeletionRetentionStrategyConfig",
					"max_number_of_indices": 10
				},
				"index_analyzer": "standard",
				"index_optimization_max_num_segments": 1,
				"index_optimization_disabled": False,
				"field_type_refresh_interval": 15000,
				"writable": True,
				"default": False
			},
			'ewoc': {
				"title": "Processing Logs",
				"description": "Processing Logs",
				# "index_prefix": "ewoc",
				"shards": 3,
				"replicas": 2,
				"can_be_default": False,
				"rotation_strategy_class": "org.graylog2.indexer.rotation.strategies.SizeBasedRotationStrategy",
				"rotation_strategy": {
					"type": "org.graylog2.indexer.rotation.strategies.SizeBasedRotationStrategyConfig",
					"max_size": 1073741824
				},
				"retention_strategy_class": "org.graylog2.indexer.retention.strategies.DeletionRetentionStrategy",
				"retention_strategy": {
					"type": "org.graylog2.indexer.retention.strategies.DeletionRetentionStrategyConfig",
					"max_number_of_indices": 20
				},
				"index_analyzer": "standard",
				"index_optimization_max_num_segments": 1,
				"index_optimization_disabled": False,
				"field_type_refresh_interval": 15000,
				"writable": True,
				"default": False
			}
		}

		streams = {
			'system': {
				"title": "System Logs",
				"description": "System Logs",
				"remove_matches_from_default_stream": True,
				"index_set_id": "",
				"matching_type": "OR",
				"rules": [
					{
						"type": 1,
						"field": staticField,
						"value": "system-k8s",
						"inverted": False
					},
					{
						"type": 1,
						"field": staticField,
						"value": "system-hosts",
						"inverted": False
					}
				]
			},
			'ewoc': {
				"title": "Processing Logs",
				"description": "Processing Logs",
				"remove_matches_from_default_stream": True,
				"index_set_id": "",
				"matching_type": "AND",
				"rules": [
					{
						"type": 1,
						"field": staticField,
						"value": "ewoc",
						"inverted": False
					}
				]
			}
		}

	X_REQUEST_CONN_TIMEOUT = 11
	X_REQUEST_READ_TIMEOUT = 12
	X_REQUEST_FAILED = 13


	def fail (*msg, errno = 1, resp = None):
		print(*msg)
		print('Params:')
		print(json.dumps(Graylog.REQ_ARGS, indent=4))
		if resp is not None:
			print('Response:', resp.status_code)
			if resp.headers.get('Content-Type') == 'application/json':
				print(json.dumps(resp.json(), indent=4))
			else:
				print(resp.text)
		print()
		sys.exit(errno)

	def api (uri, method = 'get', data = None, resp = False, raw = False, debug = False):
		reqargs = {**Graylog.REQ_ARGS}
		if raw:
			reqargs['stream'] = True
		if data:
			reqargs['json'] = data

		# Executing the request (get/post/...)
		try:
			url = Graylog.BASEURL+uri
			res = getattr(requests, method)(url, **reqargs)
			res.raise_for_status()
		except requests.ConnectTimeout as x:
			Graylog.fail('Connection timeout for url "%s":' % url, x, errno=Graylog.X_REQUEST_CONN_TIMEOUT)
		except requests.ReadTimeout as x:
			Graylog.fail('Read timeout (no data received) from url "%s":' % url, x, errno=Graylog.X_REQUEST_READ_TIMEOUT)
		except Exception as x:
			Graylog.fail('Request failed for url "%s":' % url, x, errno=Graylog.X_REQUEST_FAILED, resp=res)

		if debug:
			print('=====')
			print(res.headers)
			print('-----')
			print(res.text)
			print('=====')

		if raw:
			return res.raw
		elif not resp and res.headers.get('Content-Type') == 'application/json':
			return res.json()
		else:
			return res
	def get (*args, **kwargs):
		return Graylog.api(*args, method='get', **kwargs)
	def post (*args, **kwargs):
		return Graylog.api(*args, method='post', **kwargs)
	def put (*args, **kwargs):
		return Graylog.api(*args, method='put', **kwargs)
	def delete (*args, **kwargs):
		return Graylog.api(*args, method='delete', **kwargs)


	def check ():
		print('Checking Graylog is available...')
		res = Graylog.get('/cluster')
		print('Config:')
		print(json.dumps(res, indent=4))
		print()

	def ssoConfig ():
		print('SSO Config:')
		Graylog.put('/system/authentication/http-header-auth-config', data=Graylog.Config.ssoHeader, debug=True)
		Graylog.post('/users', data=Graylog.Config.ssoUser, debug=True)

	def ewocConfig ():
		# Inputs
		print('Inputs:')
		res = Graylog.get('/system/inputs')
		inputs = {inp['title']: inp for inp in res['inputs']}

		# Input IDs required to add static fields
		for inputField, inputConfig in Graylog.Config.inputs.items():
			# If input already exists, fetching id
			if inputConfig['title'] in inputs:
				inputConfig['id'] = inputs[inputConfig['title']]['id']
			# Otherwise, creating input and fetching the returned id
			else:
				print('Creating input:', inputConfig['title'])
				res = Graylog.post('/system/inputs', data=inputConfig)
				inputConfig['id'] = res['id']
				time.sleep(2)

			# static field
			if not inputs.get(inputConfig['title'], {}).get('static_fields', {}).get(Graylog.Config.staticField) and inputConfig['id']:
				print('Adding static field:', inputField)
				Graylog.post('/system/inputs/%s/staticfields' % inputConfig['id'], data={'key': Graylog.Config.staticField, 'value': inputField})

		print()

		# Index Sets
		print('Index Sets:')
		res = Graylog.get('/system/indices/index_sets')
		indices = {idx['index_prefix']: idx for idx in res['index_sets']}

		# Index Set IDs required to link to streams
		for indexPrefix, indexConfig in Graylog.Config.indices.items():
			# Setting index prefix in config object
			if indexPrefix in indices:
				indexConfig['id'] = indices[indexPrefix]['id']
			else:
				print('Creating index:', indexPrefix)
				indexConfig['index_prefix'] = indexPrefix
				indexConfig['creation_date'] = datetime.now(tz=timezone.utc).isoformat()
				res = Graylog.post('/system/indices/index_sets', data=indexConfig)
				indexConfig['id'] = res['id']
				time.sleep(1)

		print()

		# Streams
		print('Streams:')
		res = Graylog.get('/streams')
		streams = {stream['title']: stream for stream in res['streams']}

		# Stream IDs required to start them
		for streamIndex, streamConfig in Graylog.Config.streams.items():
			if streamConfig['title'] in streams:
				streamConfig['id'] = streams[streamConfig['title']]['id']
			else:
				print('Creating stream:', streamConfig['title'])
				streamConfig['index_set_id'] = Graylog.Config.indices[streamIndex]['id']
				res = Graylog.post('/streams', data=streamConfig)
				print(json.dumps(res, indent=4))
				streamConfig['id'] = res['stream_id']
				time.sleep(1)

			if streams[streamConfig['title']]['disabled']:
				print('Starting stream:', streamConfig['title'])
				Graylog.post('/streams/%s/resume' % streamConfig['id'])

		print()



if __name__ == '__main__':

	print()
	print('Graylog-init:')
	print()

	Graylog.check()
	Graylog.ssoConfig()
	Graylog.ewocConfig()



