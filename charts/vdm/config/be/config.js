const ptr4 = {
	url: 'https://ptr.gisat.cz/backend', // url on which server is accessible
	urlMapServer: "https://ptr.gisat.cz/mapserver", // url on which MapServer is accessible
	masterPort: 9850,
	keepAliveWorkers: true,
	pgConfig: {
		normal: {
			user: `panther`,
			password: `panther`,
			database: `panther`,
			host: `pg`
		},
		superuser: {
			user: `postgres`,
			password: `postgres`,
			database: `postgres`,
			host: `pg`
		}
	},
	pgSchema: {
		analysis: `analysis`,
		data: `data`,
		metadata: `metadata`,
		permissions: `permissions`,
		views: `views`,
		relations: `relations`,
		dataSources: `dataSources`,
		specific: `specific`,
		application: `application`,
		various: `various`,
		user: `user`
	},
	jwt: {
		secret: 'changeMe',
		expiresIn: 604800, // seconds (604800 = 7 days)
	},
	password: {
		iteration_counts: 4
	},
	sso: {
		// https://github.com/jaredhanson/passport-google-oauth2#create-an-application
		google: {
			clientId: null,
			clientSecret: null,
		},
		// https://github.com/jaredhanson/passport-facebook#create-an-application
		facebook: {
			clientId: null,
			clientSecret: null,
		}
	},
	import: {
		raster: {
			paths: {
				mapfile: null,
				static: null
			}
		}
	}
};

module.exports = ptr4;
