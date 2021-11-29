--
-- PostgreSQL database dump
--

-- Dumped from database version 11.13
-- Dumped by pg_dump version 11.13

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO bn_keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO bn_keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO bn_keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO bn_keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO bn_keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO bn_keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO bn_keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO bn_keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO bn_keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO bn_keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO bn_keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO bn_keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO bn_keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO bn_keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO bn_keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO bn_keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO bn_keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO bn_keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO bn_keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO bn_keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO bn_keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO bn_keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO bn_keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO bn_keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO bn_keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO bn_keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO bn_keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO bn_keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO bn_keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO bn_keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO bn_keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO bn_keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO bn_keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO bn_keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO bn_keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO bn_keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO bn_keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO bn_keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO bn_keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO bn_keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO bn_keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO bn_keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO bn_keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO bn_keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO bn_keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO bn_keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO bn_keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO bn_keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO bn_keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO bn_keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO bn_keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO bn_keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO bn_keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO bn_keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO bn_keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO bn_keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO bn_keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO bn_keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO bn_keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO bn_keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO bn_keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO bn_keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO bn_keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO bn_keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO bn_keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO bn_keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO bn_keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO bn_keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO bn_keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO bn_keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO bn_keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO bn_keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO bn_keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO bn_keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO bn_keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO bn_keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO bn_keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO bn_keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO bn_keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO bn_keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO bn_keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO bn_keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO bn_keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO bn_keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO bn_keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO bn_keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO bn_keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO bn_keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO bn_keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO bn_keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO bn_keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: bn_keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO bn_keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
ff1b94ee-be0c-44b0-9660-55cb28708bc8	\N	auth-cookie	master	f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	2	10	f	\N	\N
dd65e7b0-c02d-42dd-b189-9e5432ee71eb	\N	auth-spnego	master	f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	3	20	f	\N	\N
b3758999-c2e8-4e47-a2b8-a4b4a89e5160	\N	identity-provider-redirector	master	f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	2	25	f	\N	\N
bf157738-01f4-4674-982b-3cdc00a8108c	\N	\N	master	f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	2	30	t	4f498ea2-2c38-4251-9c7a-7589fac5639e	\N
dc8ce068-6ccc-4f73-b62a-de37e443db8f	\N	auth-username-password-form	master	4f498ea2-2c38-4251-9c7a-7589fac5639e	0	10	f	\N	\N
965e3f18-91eb-49a8-b23c-3d9ea8df13d1	\N	\N	master	4f498ea2-2c38-4251-9c7a-7589fac5639e	1	20	t	0df588b6-a634-43bb-b21e-be97f3350bb4	\N
fee6f61d-5030-425f-9771-2e50b2414e64	\N	conditional-user-configured	master	0df588b6-a634-43bb-b21e-be97f3350bb4	0	10	f	\N	\N
1b1a7206-1910-4e8e-b37e-c043f9fd0d29	\N	auth-otp-form	master	0df588b6-a634-43bb-b21e-be97f3350bb4	0	20	f	\N	\N
a978be15-7ce7-4671-96bb-4ea35103c773	\N	direct-grant-validate-username	master	104c9c70-583d-4458-b085-58458fc09e3a	0	10	f	\N	\N
b85e989c-3e38-4a23-b999-41a409703c7e	\N	direct-grant-validate-password	master	104c9c70-583d-4458-b085-58458fc09e3a	0	20	f	\N	\N
79b36f37-68d9-44f1-a2cf-865e699f1052	\N	\N	master	104c9c70-583d-4458-b085-58458fc09e3a	1	30	t	8e48a86e-7a9f-46d1-99c9-ffb9632d1e15	\N
b657b4b2-0c29-4c1e-bb09-452dc0851863	\N	conditional-user-configured	master	8e48a86e-7a9f-46d1-99c9-ffb9632d1e15	0	10	f	\N	\N
2072cbbe-2973-43fd-ad70-118a4a72a6fc	\N	direct-grant-validate-otp	master	8e48a86e-7a9f-46d1-99c9-ffb9632d1e15	0	20	f	\N	\N
59cc7f10-9073-491d-bfe6-52f77ee44502	\N	registration-page-form	master	a6dd9b94-82ea-4b71-8ac0-20ba1288793b	0	10	t	cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	\N
76d0395b-0088-4917-8e5d-d66bde0f6b58	\N	registration-user-creation	master	cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	0	20	f	\N	\N
a5be0138-7bfd-4bc6-8bf5-afc587b2ffbb	\N	registration-profile-action	master	cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	0	40	f	\N	\N
489e0210-a617-4dbf-b495-9a8d92461b4b	\N	registration-password-action	master	cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	0	50	f	\N	\N
9baf5200-7464-4d64-840e-a0c2f3f12b9d	\N	registration-recaptcha-action	master	cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	3	60	f	\N	\N
58533a8e-44ba-4728-9cc4-e5eac94ca6ea	\N	reset-credentials-choose-user	master	7c28d169-3d90-4004-9679-048e418f2a99	0	10	f	\N	\N
889586e2-fd00-4502-8684-c18dc7794d35	\N	reset-credential-email	master	7c28d169-3d90-4004-9679-048e418f2a99	0	20	f	\N	\N
7fea6491-9c4c-4478-82e7-e12c37e56202	\N	reset-password	master	7c28d169-3d90-4004-9679-048e418f2a99	0	30	f	\N	\N
442f983e-c219-42f8-986f-1ae930834fbb	\N	\N	master	7c28d169-3d90-4004-9679-048e418f2a99	1	40	t	8d044fc0-1a5a-40cb-b401-3a971a8889c7	\N
10ffa374-1111-4143-81f4-7ef28a11ddf5	\N	conditional-user-configured	master	8d044fc0-1a5a-40cb-b401-3a971a8889c7	0	10	f	\N	\N
281c89c2-5937-4092-87b5-da072c9e919d	\N	reset-otp	master	8d044fc0-1a5a-40cb-b401-3a971a8889c7	0	20	f	\N	\N
3aab6053-9471-4a25-9c75-b39c16a0058e	\N	client-secret	master	3279791b-5a02-45f7-a345-faacd6671dcf	2	10	f	\N	\N
0afcf516-9c21-4b6f-8520-9cc3af013219	\N	client-jwt	master	3279791b-5a02-45f7-a345-faacd6671dcf	2	20	f	\N	\N
ce1ef7ea-740e-4cf3-88ad-e70efc4c500d	\N	client-secret-jwt	master	3279791b-5a02-45f7-a345-faacd6671dcf	2	30	f	\N	\N
b9312fe4-99cb-4e12-be79-acf3fa9ced7f	\N	client-x509	master	3279791b-5a02-45f7-a345-faacd6671dcf	2	40	f	\N	\N
c177b3ce-23f5-4442-a122-0c1622f6978b	\N	idp-review-profile	master	9c774fa5-b10b-4fcd-b159-e85532360eeb	0	10	f	\N	7effb427-846d-477f-9b2c-48fcb51b27db
82cf3a4b-7963-4049-bd0f-636a8042a1ff	\N	\N	master	9c774fa5-b10b-4fcd-b159-e85532360eeb	0	20	t	d80d51c4-d3d6-4aca-a716-cb8682c610cb	\N
c2fbbe5a-4cb1-4308-89c5-db8e9d579d8b	\N	idp-create-user-if-unique	master	d80d51c4-d3d6-4aca-a716-cb8682c610cb	2	10	f	\N	9ddc2e42-aa68-4331-9c1b-6161021f3422
e6b2f1fb-99c2-47c8-98a3-678360b7e5e5	\N	\N	master	d80d51c4-d3d6-4aca-a716-cb8682c610cb	2	20	t	8cb2f1a5-2ea5-4f0d-80da-ced16f8ae2ed	\N
e9edf0a6-dd64-4162-8d14-bdbfc7c800f8	\N	idp-confirm-link	master	8cb2f1a5-2ea5-4f0d-80da-ced16f8ae2ed	0	10	f	\N	\N
ced0fb5f-49ca-42f5-ba78-ec558701053c	\N	\N	master	8cb2f1a5-2ea5-4f0d-80da-ced16f8ae2ed	0	20	t	3026bf53-d66f-483d-8fde-4cf41175645a	\N
ddec9efc-30a8-46a3-8951-5c383cde06f8	\N	idp-email-verification	master	3026bf53-d66f-483d-8fde-4cf41175645a	2	10	f	\N	\N
a571bac0-1b6a-4abc-b79b-0fa5fdc2ff6d	\N	\N	master	3026bf53-d66f-483d-8fde-4cf41175645a	2	20	t	948a2d40-6005-4ce1-8bd7-66826290dcde	\N
fa6dc333-6d15-4428-8f39-6fc23ec05a84	\N	idp-username-password-form	master	948a2d40-6005-4ce1-8bd7-66826290dcde	0	10	f	\N	\N
084992e2-cc96-4e1e-adf7-5f8620fbe371	\N	\N	master	948a2d40-6005-4ce1-8bd7-66826290dcde	1	20	t	edc9781b-87dd-446f-ac56-bc13bf463705	\N
12cae2aa-788a-4855-9894-79b2646d12a2	\N	conditional-user-configured	master	edc9781b-87dd-446f-ac56-bc13bf463705	0	10	f	\N	\N
af976f3a-8db4-413d-929d-caf7bf654c54	\N	auth-otp-form	master	edc9781b-87dd-446f-ac56-bc13bf463705	0	20	f	\N	\N
89088313-700f-4785-9003-f79c74bca23e	\N	http-basic-authenticator	master	e6553c9b-d510-4dc8-8c9b-a57952ff5d82	0	10	f	\N	\N
b8e379e7-7db4-4849-9402-e4acfb45b325	\N	docker-http-basic-authenticator	master	cf39e029-e58b-4f6e-92c7-cd6ed154781a	0	10	f	\N	\N
bfc70dbb-0f0c-4b1f-9b01-f21c2ff0f9d6	\N	no-cookie-redirect	master	0d989be3-1ac2-42c1-893a-da24e1b15b09	0	10	f	\N	\N
d31f5bb2-6f78-46cd-99d3-22103c22c08b	\N	\N	master	0d989be3-1ac2-42c1-893a-da24e1b15b09	0	20	t	de3b48d5-7b35-4b2d-bdc3-994bb7820c0e	\N
e6226ff1-34ba-422f-a926-fcebfde47d32	\N	basic-auth	master	de3b48d5-7b35-4b2d-bdc3-994bb7820c0e	0	10	f	\N	\N
cf2c5f43-1a0f-466a-a912-b40c7936b81a	\N	basic-auth-otp	master	de3b48d5-7b35-4b2d-bdc3-994bb7820c0e	3	20	f	\N	\N
ed9d0f83-ae40-441b-9778-3292b70949d8	\N	auth-spnego	master	de3b48d5-7b35-4b2d-bdc3-994bb7820c0e	3	30	f	\N	\N
f2710fce-7c18-4a67-a826-15df849a7412	\N	auth-cookie	worldcereal	c1243309-f26c-4228-95c0-2c1907127b4d	2	10	f	\N	\N
b120c97c-32c8-40df-97fd-8856ee2b6402	\N	auth-spnego	worldcereal	c1243309-f26c-4228-95c0-2c1907127b4d	3	20	f	\N	\N
d729008c-8463-49d0-98b1-fd3e3144fc5d	\N	identity-provider-redirector	worldcereal	c1243309-f26c-4228-95c0-2c1907127b4d	2	25	f	\N	\N
fe9a7db1-a2b1-460a-8886-19ca30410084	\N	\N	worldcereal	c1243309-f26c-4228-95c0-2c1907127b4d	2	30	t	372939ab-3336-45b8-8609-31b2361fed3e	\N
da2253cc-5ee0-45f8-b7e6-32b944633352	\N	auth-username-password-form	worldcereal	372939ab-3336-45b8-8609-31b2361fed3e	0	10	f	\N	\N
8708547e-c669-41ce-9da9-d6ae16739d7a	\N	\N	worldcereal	372939ab-3336-45b8-8609-31b2361fed3e	1	20	t	8edbb046-93e0-4698-bb42-83795b785e03	\N
e45c038a-0788-42cb-b638-18d2f9df1927	\N	conditional-user-configured	worldcereal	8edbb046-93e0-4698-bb42-83795b785e03	0	10	f	\N	\N
fd27e15d-af82-4dba-8657-d264dfac81ae	\N	auth-otp-form	worldcereal	8edbb046-93e0-4698-bb42-83795b785e03	0	20	f	\N	\N
580b4f15-d00a-4c60-a226-a3ce94f8df15	\N	direct-grant-validate-username	worldcereal	6f2c260a-72ac-4f12-8203-4b8c832faa48	0	10	f	\N	\N
fe98a00d-d765-47ef-bca1-1abc3105ab0e	\N	direct-grant-validate-password	worldcereal	6f2c260a-72ac-4f12-8203-4b8c832faa48	0	20	f	\N	\N
0b0774a4-63b5-48a8-961c-a15fe17d803a	\N	\N	worldcereal	6f2c260a-72ac-4f12-8203-4b8c832faa48	1	30	t	c1c41014-6613-446f-adab-a03ac688a062	\N
f58e0f64-6ea3-4d4a-a92b-46b1854b5c55	\N	conditional-user-configured	worldcereal	c1c41014-6613-446f-adab-a03ac688a062	0	10	f	\N	\N
e8050932-208d-42d7-b54e-2c28af397724	\N	direct-grant-validate-otp	worldcereal	c1c41014-6613-446f-adab-a03ac688a062	0	20	f	\N	\N
4c10d3d9-be8e-4e75-a7f7-28f023ebc95c	\N	registration-page-form	worldcereal	9d155ca7-a838-48a1-aeef-7fe4daf37dcc	0	10	t	c74d9732-03f4-42cf-9757-a1d2fb557f51	\N
c610badf-6943-4955-9c0a-62549c552ba9	\N	registration-user-creation	worldcereal	c74d9732-03f4-42cf-9757-a1d2fb557f51	0	20	f	\N	\N
c22dd42c-fedb-4f82-a119-2500407a75ad	\N	registration-profile-action	worldcereal	c74d9732-03f4-42cf-9757-a1d2fb557f51	0	40	f	\N	\N
f23d7db6-5ce5-4972-beb6-ebe04b7ffb97	\N	registration-password-action	worldcereal	c74d9732-03f4-42cf-9757-a1d2fb557f51	0	50	f	\N	\N
c9ebc429-f209-4311-b5e7-f10c92640169	\N	registration-recaptcha-action	worldcereal	c74d9732-03f4-42cf-9757-a1d2fb557f51	3	60	f	\N	\N
630bccaa-b04a-4755-94fd-96cc3861ed93	\N	reset-credentials-choose-user	worldcereal	4f2c2750-8c21-4e7c-930d-6f63409398ed	0	10	f	\N	\N
db9c91e7-521e-4cd7-ac78-c9f4c2bf183f	\N	reset-credential-email	worldcereal	4f2c2750-8c21-4e7c-930d-6f63409398ed	0	20	f	\N	\N
bd4864b2-6962-4713-809e-b2dbeafc2771	\N	reset-password	worldcereal	4f2c2750-8c21-4e7c-930d-6f63409398ed	0	30	f	\N	\N
191fb7ef-ed0d-439f-99fd-f3f761ab5e95	\N	\N	worldcereal	4f2c2750-8c21-4e7c-930d-6f63409398ed	1	40	t	055a1b00-98ab-4c89-9d89-3d6473e05515	\N
12384c61-b757-4240-9766-1cf12196cbad	\N	conditional-user-configured	worldcereal	055a1b00-98ab-4c89-9d89-3d6473e05515	0	10	f	\N	\N
1a44c7de-6750-4aff-894d-71d95ebf6e4f	\N	reset-otp	worldcereal	055a1b00-98ab-4c89-9d89-3d6473e05515	0	20	f	\N	\N
2c1212db-ffde-462b-9d5b-7eb662795b16	\N	client-secret	worldcereal	4f8d001f-9152-40b1-ba0c-381192194344	2	10	f	\N	\N
fa980d00-6c8c-4e4c-844d-64065bc06dbb	\N	client-jwt	worldcereal	4f8d001f-9152-40b1-ba0c-381192194344	2	20	f	\N	\N
3d2c9f2a-aef4-48a9-89eb-630c390129cc	\N	client-secret-jwt	worldcereal	4f8d001f-9152-40b1-ba0c-381192194344	2	30	f	\N	\N
8a62cd3a-e99b-4ac3-b9e4-20d36f60ee53	\N	client-x509	worldcereal	4f8d001f-9152-40b1-ba0c-381192194344	2	40	f	\N	\N
b5e9c1b1-c443-481b-8b93-f01c41ef668f	\N	idp-review-profile	worldcereal	89461bfb-d4c8-439d-ab4f-1fe88bd32d1b	0	10	f	\N	4f8edb49-893c-4356-9a14-e676ed49ee8d
8d2bcbfa-826e-49f6-b9fe-8f9db49ac41c	\N	\N	worldcereal	89461bfb-d4c8-439d-ab4f-1fe88bd32d1b	0	20	t	0d6b576d-c962-4fcd-95fc-e9cf19b91875	\N
da85b10a-dcc2-45c7-bc6d-648a79ead1bf	\N	idp-create-user-if-unique	worldcereal	0d6b576d-c962-4fcd-95fc-e9cf19b91875	2	10	f	\N	8ccf5fd6-8808-4972-885b-e5f3470e8dd6
0a9e313e-8e66-4902-ba49-040fda85b44e	\N	\N	worldcereal	0d6b576d-c962-4fcd-95fc-e9cf19b91875	2	20	t	7c0fd9e8-264f-43c6-b8d1-fd0d4706881d	\N
015c604a-bbc0-4613-96cd-0c2f1e86bf48	\N	idp-confirm-link	worldcereal	7c0fd9e8-264f-43c6-b8d1-fd0d4706881d	0	10	f	\N	\N
e0fa4cd1-893c-4b42-b854-494b3ed70911	\N	\N	worldcereal	7c0fd9e8-264f-43c6-b8d1-fd0d4706881d	0	20	t	f20fff85-f280-4188-ace5-6ce02573486f	\N
c9356982-a915-493a-b309-48b6a9f8d550	\N	idp-email-verification	worldcereal	f20fff85-f280-4188-ace5-6ce02573486f	2	10	f	\N	\N
eaa5333c-0fa6-4a30-9e45-5c27a799a02e	\N	\N	worldcereal	f20fff85-f280-4188-ace5-6ce02573486f	2	20	t	36ead888-16ee-4c96-b0b9-b31cdf9562d2	\N
f55f295f-3040-4c9a-b9c6-59201ed4c6d2	\N	idp-username-password-form	worldcereal	36ead888-16ee-4c96-b0b9-b31cdf9562d2	0	10	f	\N	\N
acec85ba-13a0-47b6-a9aa-f601fbf51a68	\N	\N	worldcereal	36ead888-16ee-4c96-b0b9-b31cdf9562d2	1	20	t	f48dd44a-aecd-40ca-b901-8225271e7e8f	\N
8d74cb50-b099-4bb5-8a37-506d473a2928	\N	conditional-user-configured	worldcereal	f48dd44a-aecd-40ca-b901-8225271e7e8f	0	10	f	\N	\N
a76bbf17-598c-45b4-b9b5-1d1eaffe61c0	\N	auth-otp-form	worldcereal	f48dd44a-aecd-40ca-b901-8225271e7e8f	0	20	f	\N	\N
923d0492-956f-40df-b85d-2d8084c32fa5	\N	http-basic-authenticator	worldcereal	eeb0d48d-e8ed-49b2-a5f1-b7d472a38564	0	10	f	\N	\N
8a28d8e2-b810-47b7-9f85-bb8c09593052	\N	docker-http-basic-authenticator	worldcereal	118079b9-6bb7-4914-afa7-b9c6016a1830	0	10	f	\N	\N
04a98eee-32b2-496e-99ff-078141c1c834	\N	no-cookie-redirect	worldcereal	1d3a1d3b-a770-4b7d-a341-598c27c8acd2	0	10	f	\N	\N
9ffc7c08-e2f1-4d48-8132-2238b785bc0a	\N	\N	worldcereal	1d3a1d3b-a770-4b7d-a341-598c27c8acd2	0	20	t	5e09071d-9074-4820-a341-422ee7be8dbd	\N
3e61a284-95ee-4114-b819-c2d6cb140ba4	\N	basic-auth	worldcereal	5e09071d-9074-4820-a341-422ee7be8dbd	0	10	f	\N	\N
89615571-f159-4db7-a6ad-3f505e87b402	\N	basic-auth-otp	worldcereal	5e09071d-9074-4820-a341-422ee7be8dbd	3	20	f	\N	\N
6f95c330-e7d8-471c-89d3-406e586ec33b	\N	auth-spnego	worldcereal	5e09071d-9074-4820-a341-422ee7be8dbd	3	30	f	\N	\N
309a8580-f659-4da2-9899-6134bf3ff929	\N	conditional-user-role	worldcereal	c2bfb85a-fc8a-4892-95ca-7962f790db0f	0	2	f	\N	0b90c1b6-e704-485e-af1d-430fd7547c09
45fa04f8-55c7-4e29-a3ae-8ccc688f62fc	\N	auth-username-password-form	worldcereal	e1acc578-43c8-4eed-9f71-1b0999d6f4b7	0	0	f	\N	\N
99178356-eabe-4353-8304-1d4e8bf9b6b9	\N	\N	worldcereal	e1acc578-43c8-4eed-9f71-1b0999d6f4b7	1	1	t	5d3f46b6-f4d5-4431-8fd7-d3b61b1147f0	\N
e56c8760-2c04-4d23-9331-29d0d031773a	\N	deny-access-authenticator	worldcereal	5d3f46b6-f4d5-4431-8fd7-d3b61b1147f0	0	1	f	\N	de19a26c-1aea-48d4-ac85-2b0efbdb5ed2
8f7c67b8-d4df-48af-833a-d5ac66f30e5f	\N	deny-access-authenticator	worldcereal	188f4c41-ce4f-40b2-b2fe-0fac42876491	0	2	f	\N	99970a15-af2f-48e0-9091-8102058ada4e
1dde7f61-dff9-4ab3-9fd6-838f406c4a05	\N	conditional-user-role	worldcereal	188f4c41-ce4f-40b2-b2fe-0fac42876491	0	1	f	\N	24fd0883-6657-4d30-8512-3b5b78373190
f99ebab7-07d0-4d60-ba4f-0e3a5ebc5776	\N	auth-username-password-form	worldcereal	ac7e750e-4f64-4589-904c-8a0f96bbfab3	0	0	f	\N	\N
90191439-c4c1-49dd-9d08-a6533983c38f	\N	\N	worldcereal	ac7e750e-4f64-4589-904c-8a0f96bbfab3	1	1	t	c2bfb85a-fc8a-4892-95ca-7962f790db0f	\N
837b456a-4c20-447b-ab71-0fae565ea6bd	\N	conditional-user-role	worldcereal	5d3f46b6-f4d5-4431-8fd7-d3b61b1147f0	0	0	f	\N	0296ba6b-8d95-48c7-acbb-deb946f16bf0
3168e886-98a8-41f5-bf2f-143141e4fc27	\N	auth-username-password-form	worldcereal	281995f0-3245-42c3-bb4a-9cf5b87f77d4	0	0	f	\N	\N
fc1736d0-3480-4663-8b5f-bbe44fee4d92	\N	\N	worldcereal	281995f0-3245-42c3-bb4a-9cf5b87f77d4	1	1	t	188f4c41-ce4f-40b2-b2fe-0fac42876491	\N
cce2c92a-ab87-4f95-9e7e-bc08e2ad4329	\N	deny-access-authenticator	worldcereal	c2bfb85a-fc8a-4892-95ca-7962f790db0f	0	3	f	\N	8a23ba04-23d9-440a-b90d-f269f64e4e2b
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	browser	browser based authentication	master	basic-flow	t	t
4f498ea2-2c38-4251-9c7a-7589fac5639e	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
0df588b6-a634-43bb-b21e-be97f3350bb4	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
104c9c70-583d-4458-b085-58458fc09e3a	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
8e48a86e-7a9f-46d1-99c9-ffb9632d1e15	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
a6dd9b94-82ea-4b71-8ac0-20ba1288793b	registration	registration flow	master	basic-flow	t	t
cace5998-bfbb-4e45-8602-a8dbc6cb5ab4	registration form	registration form	master	form-flow	f	t
7c28d169-3d90-4004-9679-048e418f2a99	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
8d044fc0-1a5a-40cb-b401-3a971a8889c7	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
3279791b-5a02-45f7-a345-faacd6671dcf	clients	Base authentication for clients	master	client-flow	t	t
9c774fa5-b10b-4fcd-b159-e85532360eeb	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
d80d51c4-d3d6-4aca-a716-cb8682c610cb	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
8cb2f1a5-2ea5-4f0d-80da-ced16f8ae2ed	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
3026bf53-d66f-483d-8fde-4cf41175645a	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
948a2d40-6005-4ce1-8bd7-66826290dcde	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
edc9781b-87dd-446f-ac56-bc13bf463705	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
e6553c9b-d510-4dc8-8c9b-a57952ff5d82	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
cf39e029-e58b-4f6e-92c7-cd6ed154781a	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
0d989be3-1ac2-42c1-893a-da24e1b15b09	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
de3b48d5-7b35-4b2d-bdc3-994bb7820c0e	Authentication Options	Authentication options.	master	basic-flow	f	t
c1243309-f26c-4228-95c0-2c1907127b4d	browser	browser based authentication	worldcereal	basic-flow	t	t
372939ab-3336-45b8-8609-31b2361fed3e	forms	Username, password, otp and other auth forms.	worldcereal	basic-flow	f	t
8edbb046-93e0-4698-bb42-83795b785e03	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	worldcereal	basic-flow	f	t
6f2c260a-72ac-4f12-8203-4b8c832faa48	direct grant	OpenID Connect Resource Owner Grant	worldcereal	basic-flow	t	t
c1c41014-6613-446f-adab-a03ac688a062	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	worldcereal	basic-flow	f	t
9d155ca7-a838-48a1-aeef-7fe4daf37dcc	registration	registration flow	worldcereal	basic-flow	t	t
c74d9732-03f4-42cf-9757-a1d2fb557f51	registration form	registration form	worldcereal	form-flow	f	t
4f2c2750-8c21-4e7c-930d-6f63409398ed	reset credentials	Reset credentials for a user if they forgot their password or something	worldcereal	basic-flow	t	t
055a1b00-98ab-4c89-9d89-3d6473e05515	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	worldcereal	basic-flow	f	t
4f8d001f-9152-40b1-ba0c-381192194344	clients	Base authentication for clients	worldcereal	client-flow	t	t
89461bfb-d4c8-439d-ab4f-1fe88bd32d1b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	worldcereal	basic-flow	t	t
0d6b576d-c962-4fcd-95fc-e9cf19b91875	User creation or linking	Flow for the existing/non-existing user alternatives	worldcereal	basic-flow	f	t
7c0fd9e8-264f-43c6-b8d1-fd0d4706881d	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	worldcereal	basic-flow	f	t
f20fff85-f280-4188-ace5-6ce02573486f	Account verification options	Method with which to verity the existing account	worldcereal	basic-flow	f	t
36ead888-16ee-4c96-b0b9-b31cdf9562d2	Verify Existing Account by Re-authentication	Reauthentication of existing account	worldcereal	basic-flow	f	t
f48dd44a-aecd-40ca-b901-8225271e7e8f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	worldcereal	basic-flow	f	t
eeb0d48d-e8ed-49b2-a5f1-b7d472a38564	saml ecp	SAML ECP Profile Authentication Flow	worldcereal	basic-flow	t	t
118079b9-6bb7-4914-afa7-b9c6016a1830	docker auth	Used by Docker clients to authenticate against the IDP	worldcereal	basic-flow	t	t
1d3a1d3b-a770-4b7d-a341-598c27c8acd2	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	worldcereal	basic-flow	t	t
5e09071d-9074-4820-a341-422ee7be8dbd	Authentication Options	Authentication options.	worldcereal	basic-flow	f	t
c2bfb85a-fc8a-4892-95ca-7962f790db0f	User is not in Grafana roles		worldcereal	basic-flow	f	f
281995f0-3245-42c3-bb4a-9cf5b87f77d4	prometheus		worldcereal	basic-flow	t	f
ac7e750e-4f64-4589-904c-8a0f96bbfab3	Grafana		worldcereal	basic-flow	t	f
188f4c41-ce4f-40b2-b2fe-0fac42876491	is not in prometheus roles		worldcereal	basic-flow	f	f
e1acc578-43c8-4eed-9f71-1b0999d6f4b7	Graylog		worldcereal	basic-flow	t	f
5d3f46b6-f4d5-4431-8fd7-d3b61b1147f0	Is not in Graylog role		worldcereal	basic-flow	f	f
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
7effb427-846d-477f-9b2c-48fcb51b27db	review profile config	master
9ddc2e42-aa68-4331-9c1b-6161021f3422	create unique user config	master
4f8edb49-893c-4356-9a14-e676ed49ee8d	review profile config	worldcereal
8ccf5fd6-8808-4972-885b-e5f3470e8dd6	create unique user config	worldcereal
94c3fdac-bd3f-4637-9452-8bcd572e2994	is in prometheus	worldcereal
e2a7f3fd-d89e-4f6e-8936-6e91c49ae24b	Test	worldcereal
61ededb2-8646-4543-833e-4a815b5fd65c	toto	worldcereal
1d6080cf-f14a-4cb9-a9b7-1b3928786f17	msg	worldcereal
03fcc139-2ef0-49a4-983e-7c585042fe3f	ok	worldcereal
b067f6ed-e358-42df-9b49-255d8c33e33e	ok	worldcereal
d461403a-994a-4cc0-93a3-8fad2f82ac35	ok	worldcereal
f554f147-e20b-4642-afe1-4cff0c05a53b	ok	worldcereal
57f3c04d-edf1-49ef-aba8-ec2ef4f9bacf	tes	worldcereal
99970a15-af2f-48e0-9091-8102058ada4e	Check is not in prometheus roles	worldcereal
24fd0883-6657-4d30-8512-3b5b78373190	Check is not in prometheus roles	worldcereal
0b90c1b6-e704-485e-af1d-430fd7547c09	Check is not in grfana roles	worldcereal
8a23ba04-23d9-440a-b90d-f269f64e4e2b	Check is not in grafana roles	worldcereal
0296ba6b-8d95-48c7-acbb-deb946f16bf0	check if not in graylog role	worldcereal
de19a26c-1aea-48d4-ac85-2b0efbdb5ed2	denied acces if user is not in graylog role	worldcereal
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
7effb427-846d-477f-9b2c-48fcb51b27db	missing	update.profile.on.first.login
9ddc2e42-aa68-4331-9c1b-6161021f3422	false	require.password.update.after.registration
4f8edb49-893c-4356-9a14-e676ed49ee8d	missing	update.profile.on.first.login
8ccf5fd6-8808-4972-885b-e5f3470e8dd6	false	require.password.update.after.registration
94c3fdac-bd3f-4637-9452-8bcd572e2994	prometheus.prometheus_role	condUserRole
e2a7f3fd-d89e-4f6e-8936-6e91c49ae24b	prometheus.prometheus_role	condUserRole
61ededb2-8646-4543-833e-4a815b5fd65c	prometheus.prometheus_role	condUserRole
1d6080cf-f14a-4cb9-a9b7-1b3928786f17	TOTO	denyErrorMessage
03fcc139-2ef0-49a4-983e-7c585042fe3f	prometheus.prometheus_role	condUserRole
b067f6ed-e358-42df-9b49-255d8c33e33e	prometheus.prometheus_role	condUserRole
b067f6ed-e358-42df-9b49-255d8c33e33e	false	negate
f554f147-e20b-4642-afe1-4cff0c05a53b	prometheus.prometheus_role	condUserRole
f554f147-e20b-4642-afe1-4cff0c05a53b	true	negate
57f3c04d-edf1-49ef-aba8-ec2ef4f9bacf	prometheus.prometheus_role	condUserRole
57f3c04d-edf1-49ef-aba8-ec2ef4f9bacf	true	negate
99970a15-af2f-48e0-9091-8102058ada4e	No rights permissions for this client.	denyErrorMessage
24fd0883-6657-4d30-8512-3b5b78373190	true	negate
0b90c1b6-e704-485e-af1d-430fd7547c09	grafana.grafana_role	condUserRole
0b90c1b6-e704-485e-af1d-430fd7547c09	true	negate
8a23ba04-23d9-440a-b90d-f269f64e4e2b	No rights permissions for this client.	denyErrorMessage
0296ba6b-8d95-48c7-acbb-deb946f16bf0	graylog.graylog_role	condUserRole
0296ba6b-8d95-48c7-acbb-deb946f16bf0	true	negate
de19a26c-1aea-48d4-ac85-2b0efbdb5ed2	No rigths permisions for this client.	denyErrorMessage
24fd0883-6657-4d30-8512-3b5b78373190	prometheus.prometheus_role	condUserRole
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
72b3aa15-a699-4ff4-aa82-347837b1d306	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
362ed1e8-1d67-4d7d-9c4c-200636c32d33	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
7468cf99-e160-4c11-9770-12735d71e383	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
ad44205e-56a8-4498-9fae-2cc51f899b2b	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
c2752f7b-34b4-4043-9945-0feb050e621f	t	f	worldcereal-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	worldcereal Realm	f	client-secret	\N	\N	\N	t	f	f	f
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	f	realm-management	0	f	\N	\N	t	\N	f	worldcereal	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
ad27c24a-448f-4f43-9a00-2437cd7053bd	t	f	account	0	t	\N	/realms/worldcereal/account/	f	\N	f	worldcereal	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	t	f	account-console	0	t	\N	/realms/worldcereal/account/	f	\N	f	worldcereal	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	t	f	broker	0	f	\N	\N	t	\N	f	worldcereal	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
285a7567-b365-4999-81ec-470646e1554e	t	f	security-admin-console	0	t	\N	/admin/worldcereal/console/	f	\N	f	worldcereal	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
abd75a1d-53f6-4e8f-b196-60697e70683f	t	f	admin-cli	0	t	\N	\N	f	\N	f	worldcereal	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	t	t	rdm	0	f	ca036e8b-7c36-43ea-91d2-4c8629bc2ca1	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
5981bec6-31e5-44aa-aa76-f9815198f954	t	t	processing	0	f	f7f0dac5-a0ad-4a01-a061-9796f1a10411	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	t	t	grafana	0	f	f83a7e0e-8603-4fa7-b71f-c1c997591c3e	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
f07d4e4b-371b-47db-867c-21a1853a25da	t	t	wctiler	0	f	2738c0a4-85be-44b0-8784-125b0ec8feac	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
935a293a-122f-43e2-b4a9-c57ff38e326a	t	t	prometheus	0	f	f59de7a5-caf5-474b-ae28-3ca6e29462a7	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
ef1a9afd-41f2-4eaf-9813-48873052101e	t	t	graylog	0	f	25acbd19-afe0-49d7-81b4-580010df28c7	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	t	t	dissemination	0	f	11c5290a-68f7-4fbd-ab8d-e2a2059e7072	\N	f	\N	f	worldcereal	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
362ed1e8-1d67-4d7d-9c4c-200636c32d33	S256	pkce.code.challenge.method
7468cf99-e160-4c11-9770-12735d71e383	S256	pkce.code.challenge.method
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	S256	pkce.code.challenge.method
285a7567-b365-4999-81ec-470646e1554e	S256	pkce.code.challenge.method
935a293a-122f-43e2-b4a9-c57ff38e326a	true	backchannel.logout.session.required
935a293a-122f-43e2-b4a9-c57ff38e326a	false	backchannel.logout.revoke.offline.tokens
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.artifact.binding
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.server.signature
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.server.signature.keyinfo.ext
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.assertion.signature
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.client.signature
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.encrypt
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.authnstatement
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.onetimeuse.condition
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml_force_name_id_format
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.multivalued.roles
935a293a-122f-43e2-b4a9-c57ff38e326a	false	saml.force.post.binding
935a293a-122f-43e2-b4a9-c57ff38e326a	false	exclude.session.state.from.auth.response
935a293a-122f-43e2-b4a9-c57ff38e326a	false	oauth2.device.authorization.grant.enabled
935a293a-122f-43e2-b4a9-c57ff38e326a	false	oidc.ciba.grant.enabled
935a293a-122f-43e2-b4a9-c57ff38e326a	true	use.refresh.tokens
935a293a-122f-43e2-b4a9-c57ff38e326a	false	id.token.as.detached.signature
935a293a-122f-43e2-b4a9-c57ff38e326a	false	tls.client.certificate.bound.access.tokens
935a293a-122f-43e2-b4a9-c57ff38e326a	false	require.pushed.authorization.requests
935a293a-122f-43e2-b4a9-c57ff38e326a	false	client_credentials.use_refresh_token
935a293a-122f-43e2-b4a9-c57ff38e326a	false	display.on.consent.screen
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	true	backchannel.logout.session.required
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	backchannel.logout.revoke.offline.tokens
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.artifact.binding
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.server.signature
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.server.signature.keyinfo.ext
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.assertion.signature
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.client.signature
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.encrypt
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.authnstatement
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.onetimeuse.condition
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml_force_name_id_format
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.multivalued.roles
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	saml.force.post.binding
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	exclude.session.state.from.auth.response
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	oauth2.device.authorization.grant.enabled
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	oidc.ciba.grant.enabled
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	id.token.as.detached.signature
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	tls.client.certificate.bound.access.tokens
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	require.pushed.authorization.requests
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	client_credentials.use_refresh_token
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	false	display.on.consent.screen
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	true	use.refresh.tokens
ef1a9afd-41f2-4eaf-9813-48873052101e	true	backchannel.logout.session.required
ef1a9afd-41f2-4eaf-9813-48873052101e	false	backchannel.logout.revoke.offline.tokens
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.artifact.binding
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.server.signature
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.server.signature.keyinfo.ext
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.assertion.signature
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.client.signature
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.encrypt
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.authnstatement
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.onetimeuse.condition
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml_force_name_id_format
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.multivalued.roles
ef1a9afd-41f2-4eaf-9813-48873052101e	false	saml.force.post.binding
ef1a9afd-41f2-4eaf-9813-48873052101e	false	exclude.session.state.from.auth.response
ef1a9afd-41f2-4eaf-9813-48873052101e	false	oauth2.device.authorization.grant.enabled
ef1a9afd-41f2-4eaf-9813-48873052101e	false	oidc.ciba.grant.enabled
ef1a9afd-41f2-4eaf-9813-48873052101e	true	use.refresh.tokens
ef1a9afd-41f2-4eaf-9813-48873052101e	false	id.token.as.detached.signature
ef1a9afd-41f2-4eaf-9813-48873052101e	false	tls.client.certificate.bound.access.tokens
ef1a9afd-41f2-4eaf-9813-48873052101e	false	require.pushed.authorization.requests
ef1a9afd-41f2-4eaf-9813-48873052101e	false	client_credentials.use_refresh_token
ef1a9afd-41f2-4eaf-9813-48873052101e	false	display.on.consent.screen
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	true	backchannel.logout.session.required
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	backchannel.logout.revoke.offline.tokens
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.artifact.binding
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.server.signature
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.server.signature.keyinfo.ext
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.assertion.signature
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.client.signature
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.encrypt
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.authnstatement
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.onetimeuse.condition
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml_force_name_id_format
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.multivalued.roles
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	saml.force.post.binding
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	exclude.session.state.from.auth.response
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	oauth2.device.authorization.grant.enabled
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	oidc.ciba.grant.enabled
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	true	use.refresh.tokens
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	id.token.as.detached.signature
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	tls.client.certificate.bound.access.tokens
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	require.pushed.authorization.requests
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	client_credentials.use_refresh_token
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	false	display.on.consent.screen
5981bec6-31e5-44aa-aa76-f9815198f954	true	backchannel.logout.session.required
5981bec6-31e5-44aa-aa76-f9815198f954	false	backchannel.logout.revoke.offline.tokens
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.artifact.binding
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.server.signature
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.server.signature.keyinfo.ext
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.assertion.signature
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.client.signature
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.encrypt
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.authnstatement
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.onetimeuse.condition
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml_force_name_id_format
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.multivalued.roles
5981bec6-31e5-44aa-aa76-f9815198f954	false	saml.force.post.binding
5981bec6-31e5-44aa-aa76-f9815198f954	false	exclude.session.state.from.auth.response
5981bec6-31e5-44aa-aa76-f9815198f954	false	oauth2.device.authorization.grant.enabled
5981bec6-31e5-44aa-aa76-f9815198f954	false	oidc.ciba.grant.enabled
5981bec6-31e5-44aa-aa76-f9815198f954	true	use.refresh.tokens
5981bec6-31e5-44aa-aa76-f9815198f954	false	id.token.as.detached.signature
5981bec6-31e5-44aa-aa76-f9815198f954	false	tls.client.certificate.bound.access.tokens
5981bec6-31e5-44aa-aa76-f9815198f954	false	require.pushed.authorization.requests
5981bec6-31e5-44aa-aa76-f9815198f954	false	client_credentials.use_refresh_token
5981bec6-31e5-44aa-aa76-f9815198f954	false	display.on.consent.screen
f07d4e4b-371b-47db-867c-21a1853a25da	true	backchannel.logout.session.required
f07d4e4b-371b-47db-867c-21a1853a25da	false	backchannel.logout.revoke.offline.tokens
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.artifact.binding
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.server.signature
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.server.signature.keyinfo.ext
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.assertion.signature
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.client.signature
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.encrypt
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.authnstatement
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.onetimeuse.condition
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml_force_name_id_format
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.multivalued.roles
f07d4e4b-371b-47db-867c-21a1853a25da	false	saml.force.post.binding
f07d4e4b-371b-47db-867c-21a1853a25da	false	exclude.session.state.from.auth.response
f07d4e4b-371b-47db-867c-21a1853a25da	false	oauth2.device.authorization.grant.enabled
f07d4e4b-371b-47db-867c-21a1853a25da	false	oidc.ciba.grant.enabled
f07d4e4b-371b-47db-867c-21a1853a25da	true	use.refresh.tokens
f07d4e4b-371b-47db-867c-21a1853a25da	false	id.token.as.detached.signature
f07d4e4b-371b-47db-867c-21a1853a25da	false	tls.client.certificate.bound.access.tokens
f07d4e4b-371b-47db-867c-21a1853a25da	false	require.pushed.authorization.requests
f07d4e4b-371b-47db-867c-21a1853a25da	false	client_credentials.use_refresh_token
f07d4e4b-371b-47db-867c-21a1853a25da	false	display.on.consent.screen
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	true	backchannel.logout.session.required
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	backchannel.logout.revoke.offline.tokens
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.artifact.binding
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.server.signature
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.server.signature.keyinfo.ext
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.assertion.signature
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.client.signature
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.encrypt
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.authnstatement
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.onetimeuse.condition
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml_force_name_id_format
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.multivalued.roles
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	saml.force.post.binding
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	exclude.session.state.from.auth.response
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	oauth2.device.authorization.grant.enabled
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	oidc.ciba.grant.enabled
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	true	use.refresh.tokens
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	id.token.as.detached.signature
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	tls.client.certificate.bound.access.tokens
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	require.pushed.authorization.requests
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	client_credentials.use_refresh_token
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	false	display.on.consent.screen
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	ac7e750e-4f64-4589-904c-8a0f96bbfab3	browser
ef1a9afd-41f2-4eaf-9813-48873052101e	e1acc578-43c8-4eed-9f71-1b0999d6f4b7	browser
935a293a-122f-43e2-b4a9-c57ff38e326a	281995f0-3245-42c3-bb4a-9cf5b87f77d4	browser
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
55a72f45-f3dc-490f-8830-b07d8aa0432d	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
bd8eaf25-b498-455c-9a59-78925422ce3c	role_list	master	SAML role list	saml
f5997fab-8c37-4c29-a46e-7a9659c634e3	profile	master	OpenID Connect built-in scope: profile	openid-connect
09a2727e-9d9b-463e-afc7-034822737a20	email	master	OpenID Connect built-in scope: email	openid-connect
4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	address	master	OpenID Connect built-in scope: address	openid-connect
8bc4663e-a2b7-4f40-88aa-907cc2d39e85	phone	master	OpenID Connect built-in scope: phone	openid-connect
7ed4c7bc-fb80-4494-82d2-72791ae671cc	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
3690a443-3b92-46ce-967b-7548b34a1019	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
566cc8c6-a43d-4a36-bda6-5c742f636ce5	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	offline_access	worldcereal	OpenID Connect built-in scope: offline_access	openid-connect
2643d4ef-f875-4f88-b231-9cdc89ac9a09	role_list	worldcereal	SAML role list	saml
59824934-f46d-474f-a560-b0f01ff24060	profile	worldcereal	OpenID Connect built-in scope: profile	openid-connect
c7fedcc6-3bbf-4c42-9dc0-b177212460d5	email	worldcereal	OpenID Connect built-in scope: email	openid-connect
90635ebf-9832-4048-b269-bce7874b8d9e	address	worldcereal	OpenID Connect built-in scope: address	openid-connect
f4a5dcd4-10a6-4e24-bf15-26ada44be330	phone	worldcereal	OpenID Connect built-in scope: phone	openid-connect
173db783-b6d3-4ff9-841f-236866bf5746	roles	worldcereal	OpenID Connect scope for add user roles to the access token	openid-connect
1d6717fb-659c-4b89-a2e2-f65c6719e6c3	web-origins	worldcereal	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f8b0f5dd-d33f-4339-a677-72a93242bf99	microprofile-jwt	worldcereal	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
55a72f45-f3dc-490f-8830-b07d8aa0432d	true	display.on.consent.screen
55a72f45-f3dc-490f-8830-b07d8aa0432d	${offlineAccessScopeConsentText}	consent.screen.text
bd8eaf25-b498-455c-9a59-78925422ce3c	true	display.on.consent.screen
bd8eaf25-b498-455c-9a59-78925422ce3c	${samlRoleListScopeConsentText}	consent.screen.text
f5997fab-8c37-4c29-a46e-7a9659c634e3	true	display.on.consent.screen
f5997fab-8c37-4c29-a46e-7a9659c634e3	${profileScopeConsentText}	consent.screen.text
f5997fab-8c37-4c29-a46e-7a9659c634e3	true	include.in.token.scope
09a2727e-9d9b-463e-afc7-034822737a20	true	display.on.consent.screen
09a2727e-9d9b-463e-afc7-034822737a20	${emailScopeConsentText}	consent.screen.text
09a2727e-9d9b-463e-afc7-034822737a20	true	include.in.token.scope
4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	true	display.on.consent.screen
4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	${addressScopeConsentText}	consent.screen.text
4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	true	include.in.token.scope
8bc4663e-a2b7-4f40-88aa-907cc2d39e85	true	display.on.consent.screen
8bc4663e-a2b7-4f40-88aa-907cc2d39e85	${phoneScopeConsentText}	consent.screen.text
8bc4663e-a2b7-4f40-88aa-907cc2d39e85	true	include.in.token.scope
7ed4c7bc-fb80-4494-82d2-72791ae671cc	true	display.on.consent.screen
7ed4c7bc-fb80-4494-82d2-72791ae671cc	${rolesScopeConsentText}	consent.screen.text
7ed4c7bc-fb80-4494-82d2-72791ae671cc	false	include.in.token.scope
3690a443-3b92-46ce-967b-7548b34a1019	false	display.on.consent.screen
3690a443-3b92-46ce-967b-7548b34a1019		consent.screen.text
3690a443-3b92-46ce-967b-7548b34a1019	false	include.in.token.scope
566cc8c6-a43d-4a36-bda6-5c742f636ce5	false	display.on.consent.screen
566cc8c6-a43d-4a36-bda6-5c742f636ce5	true	include.in.token.scope
f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	true	display.on.consent.screen
f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	${offlineAccessScopeConsentText}	consent.screen.text
2643d4ef-f875-4f88-b231-9cdc89ac9a09	true	display.on.consent.screen
2643d4ef-f875-4f88-b231-9cdc89ac9a09	${samlRoleListScopeConsentText}	consent.screen.text
59824934-f46d-474f-a560-b0f01ff24060	true	display.on.consent.screen
59824934-f46d-474f-a560-b0f01ff24060	${profileScopeConsentText}	consent.screen.text
59824934-f46d-474f-a560-b0f01ff24060	true	include.in.token.scope
c7fedcc6-3bbf-4c42-9dc0-b177212460d5	true	display.on.consent.screen
c7fedcc6-3bbf-4c42-9dc0-b177212460d5	${emailScopeConsentText}	consent.screen.text
c7fedcc6-3bbf-4c42-9dc0-b177212460d5	true	include.in.token.scope
90635ebf-9832-4048-b269-bce7874b8d9e	true	display.on.consent.screen
90635ebf-9832-4048-b269-bce7874b8d9e	${addressScopeConsentText}	consent.screen.text
90635ebf-9832-4048-b269-bce7874b8d9e	true	include.in.token.scope
f4a5dcd4-10a6-4e24-bf15-26ada44be330	true	display.on.consent.screen
f4a5dcd4-10a6-4e24-bf15-26ada44be330	${phoneScopeConsentText}	consent.screen.text
f4a5dcd4-10a6-4e24-bf15-26ada44be330	true	include.in.token.scope
173db783-b6d3-4ff9-841f-236866bf5746	true	display.on.consent.screen
173db783-b6d3-4ff9-841f-236866bf5746	${rolesScopeConsentText}	consent.screen.text
173db783-b6d3-4ff9-841f-236866bf5746	false	include.in.token.scope
1d6717fb-659c-4b89-a2e2-f65c6719e6c3	false	display.on.consent.screen
1d6717fb-659c-4b89-a2e2-f65c6719e6c3		consent.screen.text
1d6717fb-659c-4b89-a2e2-f65c6719e6c3	false	include.in.token.scope
f8b0f5dd-d33f-4339-a677-72a93242bf99	false	display.on.consent.screen
f8b0f5dd-d33f-4339-a677-72a93242bf99	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
72b3aa15-a699-4ff4-aa82-347837b1d306	09a2727e-9d9b-463e-afc7-034822737a20	t
72b3aa15-a699-4ff4-aa82-347837b1d306	3690a443-3b92-46ce-967b-7548b34a1019	t
72b3aa15-a699-4ff4-aa82-347837b1d306	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
72b3aa15-a699-4ff4-aa82-347837b1d306	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
72b3aa15-a699-4ff4-aa82-347837b1d306	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
72b3aa15-a699-4ff4-aa82-347837b1d306	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
72b3aa15-a699-4ff4-aa82-347837b1d306	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
72b3aa15-a699-4ff4-aa82-347837b1d306	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
362ed1e8-1d67-4d7d-9c4c-200636c32d33	09a2727e-9d9b-463e-afc7-034822737a20	t
362ed1e8-1d67-4d7d-9c4c-200636c32d33	3690a443-3b92-46ce-967b-7548b34a1019	t
362ed1e8-1d67-4d7d-9c4c-200636c32d33	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
362ed1e8-1d67-4d7d-9c4c-200636c32d33	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
362ed1e8-1d67-4d7d-9c4c-200636c32d33	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
362ed1e8-1d67-4d7d-9c4c-200636c32d33	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
362ed1e8-1d67-4d7d-9c4c-200636c32d33	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
362ed1e8-1d67-4d7d-9c4c-200636c32d33	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
ad44205e-56a8-4498-9fae-2cc51f899b2b	09a2727e-9d9b-463e-afc7-034822737a20	t
ad44205e-56a8-4498-9fae-2cc51f899b2b	3690a443-3b92-46ce-967b-7548b34a1019	t
ad44205e-56a8-4498-9fae-2cc51f899b2b	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
ad44205e-56a8-4498-9fae-2cc51f899b2b	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
ad44205e-56a8-4498-9fae-2cc51f899b2b	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
ad44205e-56a8-4498-9fae-2cc51f899b2b	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
ad44205e-56a8-4498-9fae-2cc51f899b2b	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
ad44205e-56a8-4498-9fae-2cc51f899b2b	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	09a2727e-9d9b-463e-afc7-034822737a20	t
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	3690a443-3b92-46ce-967b-7548b34a1019	t
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	09a2727e-9d9b-463e-afc7-034822737a20	t
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	3690a443-3b92-46ce-967b-7548b34a1019	t
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
adfbe5de-0bf8-45c4-ad67-64e454ff97e7	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
7468cf99-e160-4c11-9770-12735d71e383	09a2727e-9d9b-463e-afc7-034822737a20	t
7468cf99-e160-4c11-9770-12735d71e383	3690a443-3b92-46ce-967b-7548b34a1019	t
7468cf99-e160-4c11-9770-12735d71e383	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
7468cf99-e160-4c11-9770-12735d71e383	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
7468cf99-e160-4c11-9770-12735d71e383	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
7468cf99-e160-4c11-9770-12735d71e383	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
7468cf99-e160-4c11-9770-12735d71e383	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
7468cf99-e160-4c11-9770-12735d71e383	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
ad27c24a-448f-4f43-9a00-2437cd7053bd	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
ad27c24a-448f-4f43-9a00-2437cd7053bd	173db783-b6d3-4ff9-841f-236866bf5746	t
ad27c24a-448f-4f43-9a00-2437cd7053bd	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
ad27c24a-448f-4f43-9a00-2437cd7053bd	59824934-f46d-474f-a560-b0f01ff24060	t
ad27c24a-448f-4f43-9a00-2437cd7053bd	90635ebf-9832-4048-b269-bce7874b8d9e	f
ad27c24a-448f-4f43-9a00-2437cd7053bd	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
ad27c24a-448f-4f43-9a00-2437cd7053bd	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
ad27c24a-448f-4f43-9a00-2437cd7053bd	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	173db783-b6d3-4ff9-841f-236866bf5746	t
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	59824934-f46d-474f-a560-b0f01ff24060	t
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	90635ebf-9832-4048-b269-bce7874b8d9e	f
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
abd75a1d-53f6-4e8f-b196-60697e70683f	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
abd75a1d-53f6-4e8f-b196-60697e70683f	173db783-b6d3-4ff9-841f-236866bf5746	t
abd75a1d-53f6-4e8f-b196-60697e70683f	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
abd75a1d-53f6-4e8f-b196-60697e70683f	59824934-f46d-474f-a560-b0f01ff24060	t
abd75a1d-53f6-4e8f-b196-60697e70683f	90635ebf-9832-4048-b269-bce7874b8d9e	f
abd75a1d-53f6-4e8f-b196-60697e70683f	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
abd75a1d-53f6-4e8f-b196-60697e70683f	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
abd75a1d-53f6-4e8f-b196-60697e70683f	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	173db783-b6d3-4ff9-841f-236866bf5746	t
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	59824934-f46d-474f-a560-b0f01ff24060	t
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	90635ebf-9832-4048-b269-bce7874b8d9e	f
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	173db783-b6d3-4ff9-841f-236866bf5746	t
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	59824934-f46d-474f-a560-b0f01ff24060	t
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	90635ebf-9832-4048-b269-bce7874b8d9e	f
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
285a7567-b365-4999-81ec-470646e1554e	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
285a7567-b365-4999-81ec-470646e1554e	173db783-b6d3-4ff9-841f-236866bf5746	t
285a7567-b365-4999-81ec-470646e1554e	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
285a7567-b365-4999-81ec-470646e1554e	59824934-f46d-474f-a560-b0f01ff24060	t
285a7567-b365-4999-81ec-470646e1554e	90635ebf-9832-4048-b269-bce7874b8d9e	f
285a7567-b365-4999-81ec-470646e1554e	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
285a7567-b365-4999-81ec-470646e1554e	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
285a7567-b365-4999-81ec-470646e1554e	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
935a293a-122f-43e2-b4a9-c57ff38e326a	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
935a293a-122f-43e2-b4a9-c57ff38e326a	173db783-b6d3-4ff9-841f-236866bf5746	t
935a293a-122f-43e2-b4a9-c57ff38e326a	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
935a293a-122f-43e2-b4a9-c57ff38e326a	59824934-f46d-474f-a560-b0f01ff24060	t
935a293a-122f-43e2-b4a9-c57ff38e326a	90635ebf-9832-4048-b269-bce7874b8d9e	f
935a293a-122f-43e2-b4a9-c57ff38e326a	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
935a293a-122f-43e2-b4a9-c57ff38e326a	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
935a293a-122f-43e2-b4a9-c57ff38e326a	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	173db783-b6d3-4ff9-841f-236866bf5746	t
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	59824934-f46d-474f-a560-b0f01ff24060	t
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	90635ebf-9832-4048-b269-bce7874b8d9e	f
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
ef1a9afd-41f2-4eaf-9813-48873052101e	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
ef1a9afd-41f2-4eaf-9813-48873052101e	173db783-b6d3-4ff9-841f-236866bf5746	t
ef1a9afd-41f2-4eaf-9813-48873052101e	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
ef1a9afd-41f2-4eaf-9813-48873052101e	59824934-f46d-474f-a560-b0f01ff24060	t
ef1a9afd-41f2-4eaf-9813-48873052101e	90635ebf-9832-4048-b269-bce7874b8d9e	f
ef1a9afd-41f2-4eaf-9813-48873052101e	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
ef1a9afd-41f2-4eaf-9813-48873052101e	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
ef1a9afd-41f2-4eaf-9813-48873052101e	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	173db783-b6d3-4ff9-841f-236866bf5746	t
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	59824934-f46d-474f-a560-b0f01ff24060	t
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	90635ebf-9832-4048-b269-bce7874b8d9e	f
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
5981bec6-31e5-44aa-aa76-f9815198f954	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
5981bec6-31e5-44aa-aa76-f9815198f954	173db783-b6d3-4ff9-841f-236866bf5746	t
5981bec6-31e5-44aa-aa76-f9815198f954	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
5981bec6-31e5-44aa-aa76-f9815198f954	59824934-f46d-474f-a560-b0f01ff24060	t
5981bec6-31e5-44aa-aa76-f9815198f954	90635ebf-9832-4048-b269-bce7874b8d9e	f
5981bec6-31e5-44aa-aa76-f9815198f954	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
5981bec6-31e5-44aa-aa76-f9815198f954	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
5981bec6-31e5-44aa-aa76-f9815198f954	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
f07d4e4b-371b-47db-867c-21a1853a25da	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
f07d4e4b-371b-47db-867c-21a1853a25da	173db783-b6d3-4ff9-841f-236866bf5746	t
f07d4e4b-371b-47db-867c-21a1853a25da	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
f07d4e4b-371b-47db-867c-21a1853a25da	59824934-f46d-474f-a560-b0f01ff24060	t
f07d4e4b-371b-47db-867c-21a1853a25da	90635ebf-9832-4048-b269-bce7874b8d9e	f
f07d4e4b-371b-47db-867c-21a1853a25da	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
f07d4e4b-371b-47db-867c-21a1853a25da	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
f07d4e4b-371b-47db-867c-21a1853a25da	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	173db783-b6d3-4ff9-841f-236866bf5746	t
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	59824934-f46d-474f-a560-b0f01ff24060	t
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	90635ebf-9832-4048-b269-bce7874b8d9e	f
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
55a72f45-f3dc-490f-8830-b07d8aa0432d	8a961bf3-33b2-4152-895a-8f66f9ee2eae
f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	02b706f3-83c8-4174-aaa0-d8caef025762
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
2c5fc755-7bbc-42d5-bb74-c4e42e114ac6	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
a446fca3-6d45-4f37-9e64-a0949194f2c0	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
48437f6c-777c-45ae-9889-e4dd7484d1a5	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
c34b2c12-ecd9-4f01-9642-d8ed801230b2	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
59fef588-73da-4431-83c3-b942957909fb	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ad52f6eb-6e90-430a-92e4-edd07c2d72d4	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
3fff9daf-e596-46b3-b613-2f79955c8250	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
86d35c6d-3c7a-4e36-aba2-3ee8d76733fd	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
a7aea0eb-c8fe-4687-972f-6e7593cbaa25	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
0c12d508-e4bf-4a53-933c-ea17df700c30	rsa-enc-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
323ff706-d839-4830-aafd-4b08b4260ab9	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
46f7ae94-d35a-465d-a6a4-12671908b81c	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
33c1fc11-495f-45f1-a2d5-9179ab367c13	rsa-generated	worldcereal	rsa-generated	org.keycloak.keys.KeyProvider	worldcereal	\N
7389a6b5-de48-4e52-bda7-02db892cc39e	rsa-enc-generated	worldcereal	rsa-generated	org.keycloak.keys.KeyProvider	worldcereal	\N
e8e71234-09be-4694-80f9-a382db8a4a65	hmac-generated	worldcereal	hmac-generated	org.keycloak.keys.KeyProvider	worldcereal	\N
fa8c51b6-5272-421b-b543-6672cb073884	aes-generated	worldcereal	aes-generated	org.keycloak.keys.KeyProvider	worldcereal	\N
300c482d-0b12-483b-b3ca-4dae86d628bd	Trusted Hosts	worldcereal	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
14843948-e29b-4da7-bb5a-b30f990cd77c	Consent Required	worldcereal	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
3cef2db7-54ff-454c-b864-5412005a1c31	Full Scope Disabled	worldcereal	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
225c488e-7976-4ea7-9a61-a43d5ef4ea10	Max Clients Limit	worldcereal	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
d2ad7940-4f13-4ced-b379-854d56838fde	Allowed Protocol Mapper Types	worldcereal	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
9a9ca37b-4c05-4474-ad7b-80627e165a9f	Allowed Client Scopes	worldcereal	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	anonymous
713e531a-1530-43c0-9b86-c8afc4671d91	Allowed Protocol Mapper Types	worldcereal	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	authenticated
076486c7-0cc4-4060-a1eb-5ae3b9979b64	Allowed Client Scopes	worldcereal	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	worldcereal	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
3e3418ac-fa21-4797-b464-89f86767c85f	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
098f7892-301d-40d4-b786-0ac8e2af9d9c	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
7fe52d3a-35e6-4794-9e56-c0973536da37	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	saml-role-list-mapper
28fd9cd5-f8b9-49d6-9048-fe3d4196f0cc	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	saml-user-attribute-mapper
6a89952c-0d93-4cd2-abd3-9cf2a9556754	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	oidc-full-name-mapper
87279c4b-fe6d-4b21-a30a-8d1340512037	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d9813d2f-1a76-44fe-b276-fc0db39f4c9c	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	saml-user-property-mapper
fb99f400-8164-4d97-9789-e2b6da955519	59fef588-73da-4431-83c3-b942957909fb	allowed-protocol-mapper-types	oidc-address-mapper
c55298b8-f245-4e66-a8f4-cdfe255dc371	86d35c6d-3c7a-4e36-aba2-3ee8d76733fd	allow-default-scopes	true
6243e1f8-4365-4ab0-8215-b7974101a533	ad52f6eb-6e90-430a-92e4-edd07c2d72d4	allow-default-scopes	true
5efc07ba-b2a9-4aa5-aef8-c88699f56060	2c5fc755-7bbc-42d5-bb74-c4e42e114ac6	host-sending-registration-request-must-match	true
620a2672-b935-4bdc-9c58-8b024897f7e8	2c5fc755-7bbc-42d5-bb74-c4e42e114ac6	client-uris-must-match	true
d3e1c0ed-ec69-4741-80f6-a28f32ed7c0d	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5bb20d15-e46b-43b0-b01b-5f444ba8066c	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	oidc-address-mapper
f0d3ae40-be55-4956-9581-137d847e33f5	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	saml-role-list-mapper
ae514699-aa0e-49c6-8a69-4ec38a1bf39e	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
3d850acd-9840-43df-be56-c3befd5434d5	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	oidc-full-name-mapper
856792b8-44b5-4a1b-8992-e2ef3b69a766	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	saml-user-property-mapper
54d43b6b-161b-47cb-85d9-0a32455a1871	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	saml-user-attribute-mapper
82c88f1f-b32a-4caa-93a4-ebad3ed66929	3fff9daf-e596-46b3-b613-2f79955c8250	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6fddbd0b-8145-4862-84f8-c7f3f29437f0	c34b2c12-ecd9-4f01-9642-d8ed801230b2	max-clients	200
10985074-d53d-43ca-bc8a-376a0d365d9b	323ff706-d839-4830-aafd-4b08b4260ab9	kid	64a010e3-b33d-40ea-ac21-b4a4c396d5fc
05f8e4cc-16e2-4456-b768-e513aea09b9f	323ff706-d839-4830-aafd-4b08b4260ab9	secret	lOSvLjNBawhiVfwTcUQjFF60TC9Hox6XjZXeHiQc0_hQpT2T1GsSNJWTl6j6v3n5R_WrkN7Sr5pyAPGT6zcHRw
235466cf-c07e-421a-97b1-bef60ccdce60	323ff706-d839-4830-aafd-4b08b4260ab9	priority	100
0b8b3407-4830-4990-bfb2-1f76fb02b9ed	323ff706-d839-4830-aafd-4b08b4260ab9	algorithm	HS256
b57a23b2-6baf-466c-8266-ff273f31a5d3	a7aea0eb-c8fe-4687-972f-6e7593cbaa25	priority	100
0724767e-e752-42fb-a784-5b83d87893a9	a7aea0eb-c8fe-4687-972f-6e7593cbaa25	keyUse	sig
e047f08a-4ee9-4f7c-bbfd-b3a26e9a9fae	a7aea0eb-c8fe-4687-972f-6e7593cbaa25	certificate	MIICmzCCAYMCBgF7v6nvMDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwOTA3MDk0ODEwWhcNMzEwOTA3MDk0OTUwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCKp7d8SaSrNfywmk6TpZVK8ZO/ZwvCOTBkaVXWsgGsY1ErWcL0yfa5oyUWWvMrZfFkndNKr9K7yxleS3CRT56eenmZ5r1E9kE06AT+THlmB46zvaigCNLR5e5WdAhVIeRD7/ds1uNuS6jspGRaD1KLQAD5Jh/zSf5jzFCCf2LuGTBmWSoPwxujYc5jeqyRXLajJyKvsCS6FdEHlWznWC7d4n1DOi4WjtSbyjRnPljLQ3vTlbvFMp1+XwU9KP8bndZVeD0zmEcQ7wY0l+8QRRXtyVOe4NNMo60b7Ep5AJJ5gk+FLgQ6veZJFY8GCKrk9f5ZPO1MbA9fSK5uQ+zCKNtDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABgjzRr5XEpDDCUJ6vqkzueR4TVeTmXSeCLizB6y8oIa1yWMd4oTMtq5AdWPFZCBmGjUoiDbprg6KjSuKUSqWwTBq8zrCizpBZ7Jk+gm9YRAIs50kSCOAbdo0E1BVX+swldKLnmucXPCGe9cMMu4AWfnWa92VERVCx0b3pJcF15UjwbwS/SR3yVw+FoENLaXZJpjvMKKiIACwuFpAZdqftfTb4cp9d9gCc6hgWHe2B0fj/QjiESLDadWGSQRLP3n7Y8OsqF+QpvE1jtvqeDyzGfajv50b6VfzavkW5/DGsvpm4xhAqL9iNHoNGZzvuvQCChr+ZbI60ojKXGxgeZAJOY=
05d1c81c-df85-47ff-a806-1a06a46a6588	a7aea0eb-c8fe-4687-972f-6e7593cbaa25	privateKey	MIIEowIBAAKCAQEAiqe3fEmkqzX8sJpOk6WVSvGTv2cLwjkwZGlV1rIBrGNRK1nC9Mn2uaMlFlrzK2XxZJ3TSq/Su8sZXktwkU+ennp5mea9RPZBNOgE/kx5ZgeOs72ooAjS0eXuVnQIVSHkQ+/3bNbjbkuo7KRkWg9Si0AA+SYf80n+Y8xQgn9i7hkwZlkqD8Mbo2HOY3qskVy2oycir7AkuhXRB5Vs51gu3eJ9QzouFo7Um8o0Zz5Yy0N705W7xTKdfl8FPSj/G53WVXg9M5hHEO8GNJfvEEUV7clTnuDTTKOtG+xKeQCSeYJPhS4EOr3mSRWPBgiq5PX+WTztTGwPX0iubkPswijbQwIDAQABAoIBAESdEFiJ3Nn4wk3mXkIEK6fFeha6eIApasAVvCudNOTI1Q79wVL/an+csyqn4TO1o8nlq/yGm2Lg83HNJSxTWSwVcX1uSHUK42O5+VaaI20RClX54asoEqNaBCJ2EvWF6v6PjkIm6K7Y9AP+qcZDVNah2plwe1kaYa+jGKgrP5qQ0Hy3aMLIvXDqvGOha65MXvxuGEFwgwSXOSEZ9IOVHBK+s8tfEB5L9hdlBfl2xZ/J5W8NvOlZgjdDd8B1zdKPYRtJU+raLb5WAgGzFDXIrPgckIQ7cacJRybDqVnrRXtpACj4IPed1FJqV9gVE+ZxTXhGeMtqxrcWCXS4hFz6xkECgYEA5MGHdRKWDjZOOgAg77XFBXz0D0lx/OHuZHuto/Ps84QCH4oBhbsNd+vACc1a2UWvCQqmeAP4QGueifg5mwsSw5vpqPd6q33v7q18w9ILBpbQhKkN4oWhCPfhe8V+KHaFWjB5PWe5lDzOyETxDkS4Npjde96OuFGht+DuIkqmHKMCgYEAmyshiDLdZ0ZRLfTvak7Q81TXt382XGhWjS8vgImxoWLOUyU5Sw0g2dDEGWOZEWJ9BKcTx/cjdaPjOrkkOpytnlfQXwu3/ttcG7zGS/irJ5c+9mgV2SnhFWov3AVq0RT9Y1JZ//PvZRPjfNOagUcy8WTam48Bc93JcDwwM1SakOECgYB+6RuEiP40/k3iAcZEFx0qUUt5265gtNu0ZaVNC3wPEdK3urHjhoYPXPyas5JObkmQg5cdiF5HJy26r7sN2FPdr/cvJbWpxOHDEf7hCPvS+QLQRpYMcUSJHDS9nTDDtBWBltj8hzo/EolKNG1kFB37NE3UdgHKIofM4v5aif2kbwKBgDiMg2/reZzFl5g0B3yqtKO5a9RH3DvZGpHhfGJPzBiQtbi/fB3J7wrydkT6czJOvlkPurnJa3bX/1vLVVS2/N8UCbBZyPhsYSkKpwnQ2i9Xg26xiCTYilsPk9mPb9o62A12Wa5Z7AjeMq2vQEOU+w/WPYUrnM/pKBxrEvXiA2KBAoGBALg/CrLIf1+Z3QvLQ4WJL/2HXxNcssyURHS7vzTk5rM9mdhMxYnZ1kDlo4ObK70cROEh+VmCKW5orbZGX3HdZ1+KW9ZOvPr9PPui+ny4WJZGuqUTbvfOCh4BRn57rmB1PNlSIE76llv8tcdsSEC3G0aXNhwrgmN11Vt328OkisT2
c1e5ed9a-8488-47e7-8e35-f3e16a033792	0c12d508-e4bf-4a53-933c-ea17df700c30	certificate	MIICmzCCAYMCBgF7v6nvujANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjEwOTA3MDk0ODEwWhcNMzEwOTA3MDk0OTUwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCFo8v3B7iCiq+kmRTGTEed2WTZv+SENEOzTiNaeZyY9PopNCAj4mjkjc9/UfYqxdMsdbAgMUciJcpoaRLjNuTkSN/SpS/nvOqbqOqlv/pwX893+GTZvHENHWZcj0JS29ybzRjX9LjFGifUSiA8qsys1+GvyrMO8uymlYwcTArbAraxxM1gATNoYV75zcR3yrI4AcxxwON/+N9x9Q/TS4YkdCzdiqnVythDimaUnQtJnTeGtAhN3bp+HBhKC691XiQfH1jHEYNYrVF3h0HFL8IAV8kFQzDSDW0UwiSFUH+sArv+LqKZB6wugmpERiKeyg4yA7+YxtQwU2KA/ZPSxSN9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAG6XA3hf8zRSmx0QmZ563UuyqEML1G+1ZEh8W+UsLit8suxURWnV9tuBtaLItfqlTdNQokTdpvkSzaKtSRHb2B4kydwDFvp0CwFtc0ETWlHW8m0ike1YYwJvVLRgRpcMySiQNCWe0/CVcv7yumnSYvqB3bIIy34vvPbxHQGqSBOvLUHj2p/BLHEyKKQxUwyIv8+i9CYiIBDGYlMRJFAG8I4vAbLoiKfjSOF8S5rhIrJzXUc52qHAGjjMfj8GXMzlz855lfetDfjEICnIGs64uPd4StgIrq/4bHew2SpBGsH1M0f1/s0lUhx8/otu+yUOuURvsbK0Rqxo7R3GYEeTU3M=
85e5d34a-b525-46df-8a25-b0e9eb1bba17	0c12d508-e4bf-4a53-933c-ea17df700c30	privateKey	MIIEogIBAAKCAQEAhaPL9we4goqvpJkUxkxHndlk2b/khDRDs04jWnmcmPT6KTQgI+Jo5I3Pf1H2KsXTLHWwIDFHIiXKaGkS4zbk5Ejf0qUv57zqm6jqpb/6cF/Pd/hk2bxxDR1mXI9CUtvcm80Y1/S4xRon1EogPKrMrNfhr8qzDvLsppWMHEwK2wK2scTNYAEzaGFe+c3Ed8qyOAHMccDjf/jfcfUP00uGJHQs3Yqp1crYQ4pmlJ0LSZ03hrQITd26fhwYSguvdV4kHx9YxxGDWK1Rd4dBxS/CAFfJBUMw0g1tFMIkhVB/rAK7/i6imQesLoJqREYinsoOMgO/mMbUMFNigP2T0sUjfQIDAQABAoIBABDUxlWAdW6LhP+YABPRe5uXy6nZDzDPXE9y4eT9OAnToMYbuIiMdWWDrsR8UCKm86e/0sTbL/hPBiUMRsKzITTXMMlY4KWxF2MvbQ4fFa2dg4W6lQkPQLXEJCY4LMQ+yJQeyqg4PCUm3ClShKjfYhPKxLPdNZwGYGPCpfjSYvOePyrfEeUVBWz/oUcTQvcyzrOtVdpV/cT+xwsOf0nZi9GU0Bt1o92xiOJlnyLXfZ6o8KkAU8Nn7i2jEQnmmH4xURpe1siZ7phwq/YEd9Ue2YkK4lB4NZXEiKAAAB0xmnNkFvu5jfHvP+VXkhITe5DW612IxQ7274JaZu40D6CogEECgYEAxpDygzrfuf/rWZCTyHcyqFXZnshV1vap9gtk0coZmp7VuXKVOP7o+AnmJA3TZIMwepYkayMyevpdrj4hw46tfb+yUcFI2RQ2qJahajtfIDxk8K7s4H5k/LbAOtne0dkmTjfRd52TrviR6H8FqoXnIIBjpaksNseGwoua8IfOEOUCgYEArEtOFCx75iWfE6f8E58mpl8V1PfkQNwKPiO1cy9xI6/HtffWgiqkYr1RF2ai7hsEXJusL7DpmgfUicay80IhAk/LxjfR/p4O7qQ3+ZsZrvs0bmi+dhql8g53BdtHQtop9JKtAu0mJWNcxLZg3DRZ1ayI4i3CPNmS1ah/rGOWVrkCgYAXLmbRgTcLPOBZ9XH7Tkcgtd0RF2xGC0fuTIg5obF5hp+G5eSb4c6K3oT6oo6SRmqLdSnNRC+pgb8cD27bqLWCX7XOq5T4ms6CwgsYHtRNLB/QpWtMDhV2F1O7yyGjOAmrygJvR3stSyGlleawcK958OMxPN3Hi2WlIq009XXOLQKBgB8p58+CVE7Gk0Vs5w1thgIlxL8mr2SD6F5g+xsAg8herRLe5y/YIq+xao9/Aw1qWZmelsBxkW9I50qcZBXX6jyOzl7mDdeuIylLDszZHwYlbdBipcCbBVUJBMJMbVFMQLZ6KU0UNAgjNs5l5pMt7OnXMVMnz7BN8l8vARjfUnwRAoGAe++3tOhqON5racNdu1CzDSg2QzIBOymXfQq+AyS/wjJwW0lfKuowGR1ve8P4/kCZtmMheOQgFDMuhmhKurNEkNwTjmqAG9OOGGCssAGk1NfauBNDD+usHWA4d4VnN3xWAuPNHpiJMc2jlRb9d2aXs/msnjFlrA54LqCaeFI8w9Y=
0228fe52-8630-440c-9e45-4c6fa8ebf1bd	0c12d508-e4bf-4a53-933c-ea17df700c30	priority	100
4db824b2-d3e0-4b84-8b74-0aeb0d0ec436	0c12d508-e4bf-4a53-933c-ea17df700c30	keyUse	enc
033d8429-cee5-47c8-a141-247cf9a81595	46f7ae94-d35a-465d-a6a4-12671908b81c	secret	wngfi0ekZzs8Oh9ZalS0dw
f8739a99-eaf9-489a-9623-5e3a621d09ab	46f7ae94-d35a-465d-a6a4-12671908b81c	kid	7cfac72b-cd41-45e7-937b-c2abaa08bd35
645b5038-6b4f-4522-b863-5aa8359ba3a8	46f7ae94-d35a-465d-a6a4-12671908b81c	priority	100
2b8c7157-f203-480d-b0cc-9149caf97c8b	e8e71234-09be-4694-80f9-a382db8a4a65	algorithm	HS256
06dd1624-24d9-4b07-ad75-c622115bb5b9	e8e71234-09be-4694-80f9-a382db8a4a65	priority	100
758857ac-6fad-4d21-b41b-01886c116362	e8e71234-09be-4694-80f9-a382db8a4a65	secret	2TOst68PYcGNVpGZuKhOru7POGRMxDYVOhIsGXSUdLh-kwL6XPBumO91uhSImu1tOk4z8v7GCa9uC4upC7GjIg
2ab86252-bc61-4c63-abce-9d2a2bb5e83b	e8e71234-09be-4694-80f9-a382db8a4a65	kid	e5372474-4f5d-4c0a-8973-ae3177429ce8
55c64dcb-80d3-44ec-aa99-f01e204dfa3e	fa8c51b6-5272-421b-b543-6672cb073884	kid	f035af9a-531c-44cd-8917-ba0675317a0d
2fbf9f99-669f-4f13-9c17-25a8a461741c	fa8c51b6-5272-421b-b543-6672cb073884	priority	100
e65f4bfd-1aea-4657-86df-b1cef9d0eaba	fa8c51b6-5272-421b-b543-6672cb073884	secret	5t3egHWofEV5e3OSOysiNg
0ede15ca-2dbe-44ef-a5bb-8779d074d5e7	33c1fc11-495f-45f1-a2d5-9179ab367c13	priority	100
cc1d26ac-39c8-4c5f-8ad2-b2d3472662be	33c1fc11-495f-45f1-a2d5-9179ab367c13	keyUse	sig
e2634651-23f0-4da7-8b7f-60ff19ffc648	33c1fc11-495f-45f1-a2d5-9179ab367c13	privateKey	MIIEowIBAAKCAQEAh435HOYeHMfB/hCi1gn9RiLdwSQ3eB9Ooo/eFsmTT202CrDHQ9e3kmMgmQQ38vB8iLlkIHfYIl2vFvvyKs5p1h+UzYdknzoQCnkfNUgaQp5JOI0KiORoXFPhQ0o7hh9ZNuDV68EViy1WpReT2oeNcS4IpygMVovbuyhWntAvAJgJvjGmS+9x3bPQaXpnXf1blOwYiyWNNgGtR5KY6uZN1rpiYZlaSX4cdRL7XmxpgB5gqyuS3VN3ounsFGUHwXhtuloyk/PgW2aI0yJSnqRIa04+NW3Wa1+wKkWNBCFoy+zMNNskv91wYkcvr2yn+ozfEJ00yWMcWNimmJJS4VZsLwIDAQABAoIBADTI5CiMs00hvDji4YXXffjBuvhq0e7EwiorO6BD/kj/jfu7utyAM8udLiRnsCG548SZ7JN4F4HKWVPp5/MjTbNDuP4Pqu8V/QkXAUAOQ6uNV5Xd1ixYRQsu3pkFXwhrTKJCCwsytODtVsAS3lBKWJmqA1SUE7nf3ECVBKXzC1p/SHlra0PPRE8hjCEHs/7nkdF3l0zcKZDtF++75LD6jx4IsLZvJ7rGb8zZ5HXEtAElFTKpQhZ/CruDiALAml0HJGmlZjvklTfU4hr74d2qZQVT+Tgsc0Q+jUe3e5ey1m+EOKDTvEdDueKz3r6R2EK2gqRfKP+ugJfUPRFK9KruT4ECgYEAxV4vL/6sa2ABWuCiCZGa+jQU87HO7zkrwuoowNy/C8LN2mMHHUHT0y5sKdcavA1Z8jDDfzoBUb83KmBwKbZNuvui8hbzHG1vPad/WoLba7Cre8CxFtRE5XLvvl4wtBsD9Zcuh1HmHtzOzpCDqOimc7xg43F2LCP9Ll4yVQQFJXMCgYEAr9LjwmMlFzMBUByg8WS+qVpTcdhXMda63MEL5/nwC2vM7MxV6IGqLh5EvSX2kzpXEP0SAA8qpvzBAYUA7xSfDCLuTh4y1KheE1E20p2q+2M7klgcc/yvFHvm3hCHb33DXBpCjW33TpFer0KyMmJ78/ebrptCzcuuKLlpZsYDz1UCgYAchDAzMgu9c+CePciLs2L99Zp1X2JzxAHjpqt+uiZMT7gobphvjLxLTfDI1tCBDTjKumr0re/U3NjeoZJzJGj0tDjl25UCrXkeIl5POIr1c1BDkCLGFqNht4qWKcvFqgWXbWGGobmrCeJDjDPJqtup6zTgh9s4I3cIRQnmqK8JqwKBgQCoHFYVGMLwCZ6pwJXJ+O+r8WdzpMzKJGwKgrIlnX59DRelGkLRypiy+9HxoIjAgLmazr4VPGsluum30DnyXp8r9YIxQwKK/mjkw3RNsN84+cqNxJ1/8Qxd45H8pYU5ft/6Akm7/HbHsor7vCOxtSSbQhaivmUDbEobOhyjXZVq+QKBgER9YRx2jx/nKzX15K+GqmECHne+8ODmRNKvkL7XP9ORzqmO7GZfhVYtWF4OhfvZkBbJJsAuQ5lzfPOfGIuddsu0LyfLe4KFYU0hupatbdrRJq6Uawy1C8UrSN2Sgg1D4Y+pL2t1YeNz9qLeR9yEmv0EMEsMo01zgPacxPzLfEWy
2ad4e8b8-cd03-465c-9acb-55386124e4ff	33c1fc11-495f-45f1-a2d5-9179ab367c13	certificate	MIICpTCCAY0CBgF7v6xjfjANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAt3b3JsZGNlcmVhbDAeFw0yMTA5MDcwOTUwNTFaFw0zMTA5MDcwOTUyMzFaMBYxFDASBgNVBAMMC3dvcmxkY2VyZWFsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAh435HOYeHMfB/hCi1gn9RiLdwSQ3eB9Ooo/eFsmTT202CrDHQ9e3kmMgmQQ38vB8iLlkIHfYIl2vFvvyKs5p1h+UzYdknzoQCnkfNUgaQp5JOI0KiORoXFPhQ0o7hh9ZNuDV68EViy1WpReT2oeNcS4IpygMVovbuyhWntAvAJgJvjGmS+9x3bPQaXpnXf1blOwYiyWNNgGtR5KY6uZN1rpiYZlaSX4cdRL7XmxpgB5gqyuS3VN3ounsFGUHwXhtuloyk/PgW2aI0yJSnqRIa04+NW3Wa1+wKkWNBCFoy+zMNNskv91wYkcvr2yn+ozfEJ00yWMcWNimmJJS4VZsLwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCAZQtOGJmVPrOeT1NJReF95NZbRxt1dkY65IQOk007uxQEkcTchu+Mb6YBBXqRtbacPSUTINNd4xhrnknPu3BYf37ZLnvkSr7qmSfV69i2jEkoTxCmTDc5VjyPCndxj9BgWEAIL2hboOLIOf4EPO4oE2rkOPtX9w81nrhnwKIgva5Q+QXyBU0EmQehhQFqrjxH0Bpv8t8UeCRU2Bsew8CfA6UNP4HRcciSiwPiDOUfKT+MuiaToQFz5vIpubJ38EjtVzQujm4y1EOGXx4cR7gJsJsy1VYvWUdeM2fzCjHMYYMfthqO21z38sQLWmODdB27uVmcf0wFXu5b45Ka1Rje
0b71964c-ae59-4c54-9a41-2e9f7a3fdbb6	7389a6b5-de48-4e52-bda7-02db892cc39e	priority	100
d1a74e74-971c-413a-baf1-a1603009cf47	7389a6b5-de48-4e52-bda7-02db892cc39e	certificate	MIICpTCCAY0CBgF7v6xklDANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAt3b3JsZGNlcmVhbDAeFw0yMTA5MDcwOTUwNTFaFw0zMTA5MDcwOTUyMzFaMBYxFDASBgNVBAMMC3dvcmxkY2VyZWFsMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzEtkZ73z2AgVYQSsd34msN25NGRAW1ZbwPWRzyqvFs1aCmLBxzqNKzHA8mKwaz8mCRnAf+Aw3hGR+ouaa7JZPlNzuhMAYsesUeBeNuBgL8Qt0cYnTUH9zW8nVD5/c3WouI5D+JV7nLvk6iGOis7smEstX/rBStcSBG0zp83u1aZOYLAXw9WcV9GjV9rJJJgvQqEDJxCyJjqvG9f6g/Ng/6jw2kYsetrQIAyrcWEpfdvrYbe/yBY3DMTIr6v9ilsilub1IMSWhNvm3pEF6xfMhYjK3tmzOwlJ9oVHz0sFkwvkzkxYdQYMyf5uuzSHYuGHITbSVwPnCmx+FhE1CAOFvQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBXpinJUG05JX9SsRx6DoNwzBPz8KxONuIIwO9EPuBDcR2M4nPbdZr1iL1EpXk7gBFSW0djXM5dowa+W88LVXuRhJ2d4wx9qS6p16JfYkZG/MKclFOXm20XWokD9lrZAq2HdQRY0aaNfcRTpdIzaCoy9vThkAk3EFMBhRJ2YVjkgcwxdatNds8dVZdZt8XgUKcUs5iKfmliutGaEZvtLNGMyK9D4PI8Do1uupLKvkgVAms+wWM13afEPDLcFE3gyMuD4HuOD00g13JExPWY2n5+oKZPDiD1SnjX8ETPXDwOZFZk8t0j9bdeVuk2JIkJtq0rBDyUgJVZjgsNk0f5J5KV
1da371aa-33df-45b0-b721-b7b0e5775d1c	7389a6b5-de48-4e52-bda7-02db892cc39e	privateKey	MIIEogIBAAKCAQEAzEtkZ73z2AgVYQSsd34msN25NGRAW1ZbwPWRzyqvFs1aCmLBxzqNKzHA8mKwaz8mCRnAf+Aw3hGR+ouaa7JZPlNzuhMAYsesUeBeNuBgL8Qt0cYnTUH9zW8nVD5/c3WouI5D+JV7nLvk6iGOis7smEstX/rBStcSBG0zp83u1aZOYLAXw9WcV9GjV9rJJJgvQqEDJxCyJjqvG9f6g/Ng/6jw2kYsetrQIAyrcWEpfdvrYbe/yBY3DMTIr6v9ilsilub1IMSWhNvm3pEF6xfMhYjK3tmzOwlJ9oVHz0sFkwvkzkxYdQYMyf5uuzSHYuGHITbSVwPnCmx+FhE1CAOFvQIDAQABAoIBADdkseLXRIjtGC7oP4Ne90q5tAAatsCNV++oJlMP9c2u/J0YTgahP6nYocKXM9LAmqWZD/McbOOpy/UtaT+OalhV9GkdwdsG3RiOR72FdU8+WFYq7nkqTZEodHeJQrGh04/HM3LxxUSoRdeeJbJJjSl2KOV/bm3GhyIgIgN7+SiApWhCPbQnqv9l5mq/j7+LZGGvPHixFUSvFe3xfyzpIRZqgQb7yoyPgh6uxqkC8+Q3LuNP+B/nMDy54Y9PD3ENAP+CCKRaK5Sz+7DWaXBpsj7XTJWp+cp8d76AksyIxHXfgeawsmAbI0OHQHPNHLXIuoiN6UHWLpHVD4RmdKKlP8ECgYEA689rrbtjZeyqFovxdc0Rcs50/+QojEBVN/MEAj3J/nHF706jC9rudTAEFSEYBz7EA1JGjsXEcfq/K+0Xo+b1bGmYkVJU6AzWug0Gi3zzkgC839NReiNe/hTmFftiV4pnlok7QKGqZ8jt9QBjxI6nccxO8nE7KhyKRJo7g6+KmpkCgYEA3ckylGkfGbSzPHUoMABwLUwZXmWLxoC67eGj7E+bmSHCSG6NspWUJmjU9uWDAVq87d+ScwVEqHXxPNrF7QNdnVVIgos7yn2se/R12CyxFXyezk4Ux1zIblsmGvaiZDxGQ8AWhfby1VeUyIRdrRdlrBbsZqEEOu0ykD8KYEelvsUCgYAcf0SUCkFI4ADuGJtlkRK6vRiGlBwSVvP1fvjNDIqMpVM2SFqL5DlNEDBuHUG6Hmuxuw+r0VqcK6FOvahNtmuSXnCBn2GDaYnJkiloUgFdc5lfszn1eLDSI9Rqc6a+zYsXNh5jASaGxFF9ej6UUmkJ55bi1axAupI7GCh5EY2+gQKBgHBJGM6CmjhNgCEvv3TuA90rFfzwtF9/dSRShMdzVnek29QIBL1RdXwsvwVxFW5uHhDgjCinlicj70q8CFECzzaEov1UuKTAE799+NvFZLJYMZ6JcYOtudwFUbl8/KJ60agjbEPOzwqsGKucOEEWA2epA27CPn4G8P6OrBYqsANxAoGAYFwjsmBJ4COuCcmlKuZg1S7Km5rmf7J4TlsvdmWB4iflfJ+qmMqMrB7pUrxVZsAe4UAotdVH7IUbdr1OHAOXPgITT6Tg5kW5p29uFls8fK78JYhQgn6BiJ7j/mnzdvOqZMMbivAcwop+9SXRaEoai5dZPZfUbMpeLx8lPwc2MSM=
02d0683e-3042-4e52-b974-6a54fe5907f8	7389a6b5-de48-4e52-bda7-02db892cc39e	keyUse	enc
30309d85-e230-430a-b7f4-03e740b4fe60	300c482d-0b12-483b-b3ca-4dae86d628bd	client-uris-must-match	true
d4fefe6f-7cf6-448f-ad5e-fd1166db2a30	300c482d-0b12-483b-b3ca-4dae86d628bd	host-sending-registration-request-must-match	true
d59ea26a-617f-427f-8aaa-61c2066e7124	076486c7-0cc4-4060-a1eb-5ae3b9979b64	allow-default-scopes	true
1083c242-3afc-4ec0-936f-f0bffd908bff	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	saml-user-property-mapper
2ac61d8a-5093-420e-b32e-78808002ecf9	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
bc210a0b-ebee-43a5-ab3c-f5948b5fbab7	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	oidc-full-name-mapper
63232aef-9901-4d0c-813b-09867c26f261	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	saml-user-attribute-mapper
a94da82e-f499-4611-a1a4-767f1533e425	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
1e185adc-97c1-4521-89ee-5041b2d60e77	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	oidc-address-mapper
b6d64777-9afc-4ff1-9320-1eddc9350b65	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
6ff3ced8-98b7-431a-aec6-531cf2c02ba2	d2ad7940-4f13-4ced-b379-854d56838fde	allowed-protocol-mapper-types	saml-role-list-mapper
2c0d08ca-8e81-4804-9ee7-fd43d5820999	225c488e-7976-4ea7-9a61-a43d5ef4ea10	max-clients	200
81e687d0-8e72-4e13-aac8-ff33133b26e0	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	saml-user-attribute-mapper
e21f5804-91c1-412f-a466-279d36ef04df	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	oidc-address-mapper
ab946788-aa8c-402f-99ac-745685064dbd	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
77d69f21-21c0-4df3-92f7-b8103e76ed19	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
cbfee8e0-66e3-4bc2-ac37-8d85a5fcb361	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	oidc-full-name-mapper
92ac0f39-683e-4c2c-bdc7-c464774c151d	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3fbc1bb9-8ee4-4143-8384-325a5866f26d	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	saml-role-list-mapper
4474a73f-aff7-4b1b-a7df-3f5bd6957c89	713e531a-1530-43c0-9b86-c8afc4671d91	allowed-protocol-mapper-types	saml-user-property-mapper
ff025449-8868-49e9-9fa8-28f8196dc04c	9a9ca37b-4c05-4474-ad7b-80627e165a9f	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
ea29a635-4e34-458e-9459-b16a5f79ffc0	bdc17c21-733c-4acb-8b7b-993c6b466a45
ea29a635-4e34-458e-9459-b16a5f79ffc0	d68c9db3-b9b6-4df9-a2f5-961b70919f29
ea29a635-4e34-458e-9459-b16a5f79ffc0	d8661d38-8530-40fe-b501-45d20f91a9c5
ea29a635-4e34-458e-9459-b16a5f79ffc0	f25fe4f7-9ebc-44b2-8e5d-a1814ea0e825
ea29a635-4e34-458e-9459-b16a5f79ffc0	42e663b2-b193-4ba9-9e09-2f6e3acc6a6b
ea29a635-4e34-458e-9459-b16a5f79ffc0	7fa725bc-9a7d-490a-8a19-e048bf58a410
ea29a635-4e34-458e-9459-b16a5f79ffc0	7e2d9320-0c2d-4f30-9b37-a8149323eaa2
ea29a635-4e34-458e-9459-b16a5f79ffc0	eb45662a-924b-4c67-ad3e-8feba489614b
ea29a635-4e34-458e-9459-b16a5f79ffc0	982f8761-0258-4a21-8844-5e164997f697
ea29a635-4e34-458e-9459-b16a5f79ffc0	c4e950d5-bddf-4895-9c6b-ceda6870ef76
ea29a635-4e34-458e-9459-b16a5f79ffc0	cd73ff6f-033b-4d8c-b2a9-7c3719614d2d
ea29a635-4e34-458e-9459-b16a5f79ffc0	5ae323fb-89a1-49fe-88ac-1990acc2f5c9
ea29a635-4e34-458e-9459-b16a5f79ffc0	378a92c2-c1b1-4d9f-a0ab-16443f03c3be
ea29a635-4e34-458e-9459-b16a5f79ffc0	ad100d91-9d47-46d4-908b-ed1adc7e9810
ea29a635-4e34-458e-9459-b16a5f79ffc0	26eb316b-d953-4cd0-8a9b-398086ddacb9
ea29a635-4e34-458e-9459-b16a5f79ffc0	4ef22280-a8bd-49e1-86bc-9ca3057abcb6
ea29a635-4e34-458e-9459-b16a5f79ffc0	cb62a86c-2527-4af2-840b-6a0058ac8ce3
ea29a635-4e34-458e-9459-b16a5f79ffc0	c5d73ccb-5a0e-4130-86db-24a44750c5b3
42e663b2-b193-4ba9-9e09-2f6e3acc6a6b	4ef22280-a8bd-49e1-86bc-9ca3057abcb6
f25fe4f7-9ebc-44b2-8e5d-a1814ea0e825	c5d73ccb-5a0e-4130-86db-24a44750c5b3
f25fe4f7-9ebc-44b2-8e5d-a1814ea0e825	26eb316b-d953-4cd0-8a9b-398086ddacb9
b29eb198-4a7d-4930-84a8-20097bdc64a6	85586b7d-3062-4230-9539-42b682652d66
b29eb198-4a7d-4930-84a8-20097bdc64a6	b51a10bc-c877-46d2-a1e2-7453c13eea8b
b51a10bc-c877-46d2-a1e2-7453c13eea8b	32cefccf-a74b-418e-925a-d1bff2be5f25
cf0278a0-f475-4950-b3d9-23b6d11f3d6a	b8699a36-1c50-42be-83f5-66a3f0f630f4
ea29a635-4e34-458e-9459-b16a5f79ffc0	6f7d741f-04aa-4710-bdd8-e440c777f6b0
b29eb198-4a7d-4930-84a8-20097bdc64a6	8a961bf3-33b2-4152-895a-8f66f9ee2eae
b29eb198-4a7d-4930-84a8-20097bdc64a6	2c0e14ef-6acf-46dc-ba46-746f5ada0eef
ea29a635-4e34-458e-9459-b16a5f79ffc0	8e026a80-9c12-4aba-813a-e532da7d5a8b
ea29a635-4e34-458e-9459-b16a5f79ffc0	3fc2526a-630a-4e66-a5ed-e9d064513561
ea29a635-4e34-458e-9459-b16a5f79ffc0	2f402c87-39fa-440d-b03b-966b3f85694c
ea29a635-4e34-458e-9459-b16a5f79ffc0	56cfaa43-b4df-4e2b-8a0f-2503013ad650
ea29a635-4e34-458e-9459-b16a5f79ffc0	cb481723-c7a1-486b-b50e-6f8aa61f9603
ea29a635-4e34-458e-9459-b16a5f79ffc0	ab813679-58d4-4b16-a3ae-1c01a187678e
ea29a635-4e34-458e-9459-b16a5f79ffc0	fdf02ae8-bcc1-42ed-b1d9-de5b7b128619
ea29a635-4e34-458e-9459-b16a5f79ffc0	44ae2542-d762-49d5-af41-05e279167e77
ea29a635-4e34-458e-9459-b16a5f79ffc0	e0904c9a-c68c-496e-9fc2-dd170ae59846
ea29a635-4e34-458e-9459-b16a5f79ffc0	bf7dc6e2-e666-4023-98f3-8272e6ff4700
ea29a635-4e34-458e-9459-b16a5f79ffc0	0101b97d-3dde-4f5b-9331-05e0a9cdcc25
ea29a635-4e34-458e-9459-b16a5f79ffc0	194bbf48-e30c-4f8d-bf89-cbe4b154faf0
ea29a635-4e34-458e-9459-b16a5f79ffc0	fa9c5305-00a6-4f3f-ac99-822af41687fb
ea29a635-4e34-458e-9459-b16a5f79ffc0	04d83ca1-9763-4f28-9b3f-2a682e7b6929
ea29a635-4e34-458e-9459-b16a5f79ffc0	192c8137-1b30-42a2-877c-09f1a2daa490
ea29a635-4e34-458e-9459-b16a5f79ffc0	3792875b-efb2-40f4-aad8-748f84b81aef
ea29a635-4e34-458e-9459-b16a5f79ffc0	164d9a8d-6e19-4867-a451-3c6910dd599f
56cfaa43-b4df-4e2b-8a0f-2503013ad650	192c8137-1b30-42a2-877c-09f1a2daa490
2f402c87-39fa-440d-b03b-966b3f85694c	164d9a8d-6e19-4867-a451-3c6910dd599f
2f402c87-39fa-440d-b03b-966b3f85694c	04d83ca1-9763-4f28-9b3f-2a682e7b6929
85fb0bb8-768d-408c-b593-e3a4dabf7281	b7053a20-71b1-4383-8fb0-8f21b7d35bbe
85fb0bb8-768d-408c-b593-e3a4dabf7281	f13df049-cf47-46ca-b295-9c9ec27dcd3b
85fb0bb8-768d-408c-b593-e3a4dabf7281	2c0523e5-9a9c-43f0-8451-815968afda95
85fb0bb8-768d-408c-b593-e3a4dabf7281	b0df074e-3179-4e18-8772-31d3679d7bb1
85fb0bb8-768d-408c-b593-e3a4dabf7281	0e69c95a-deb3-4a94-955a-0c80f717ae09
85fb0bb8-768d-408c-b593-e3a4dabf7281	d49e6ff6-be68-4c14-a88b-bbf776c60768
85fb0bb8-768d-408c-b593-e3a4dabf7281	b14a1f7e-3793-4106-b271-c3395ab511f9
85fb0bb8-768d-408c-b593-e3a4dabf7281	0cc8bf7e-72bd-4d40-ad8b-e6a23e8f6206
85fb0bb8-768d-408c-b593-e3a4dabf7281	9696fe12-1886-49bb-81cf-bf3644a3b533
85fb0bb8-768d-408c-b593-e3a4dabf7281	8518f31f-a672-439b-b8d8-9e480544674c
85fb0bb8-768d-408c-b593-e3a4dabf7281	c5302c46-3220-4977-aa07-dd089c857ed5
85fb0bb8-768d-408c-b593-e3a4dabf7281	d006f0bf-7880-456f-aa68-0c2b1ffffd96
85fb0bb8-768d-408c-b593-e3a4dabf7281	b9d31279-7e21-41ee-8557-c8bdcf5961b2
85fb0bb8-768d-408c-b593-e3a4dabf7281	54293a2f-7098-4149-9346-1f3434841cf1
85fb0bb8-768d-408c-b593-e3a4dabf7281	50465b19-118b-4f90-92c8-850cd5a2903b
85fb0bb8-768d-408c-b593-e3a4dabf7281	467e7046-9ba4-4904-b2a4-0fa269eafd1c
85fb0bb8-768d-408c-b593-e3a4dabf7281	468b3de4-10a5-44fb-b7aa-0c210a722c84
b0df074e-3179-4e18-8772-31d3679d7bb1	50465b19-118b-4f90-92c8-850cd5a2903b
2c0523e5-9a9c-43f0-8451-815968afda95	54293a2f-7098-4149-9346-1f3434841cf1
2c0523e5-9a9c-43f0-8451-815968afda95	468b3de4-10a5-44fb-b7aa-0c210a722c84
439b847c-bca8-40fd-a6f0-eb20958acd50	70f8ed59-d8ad-4227-91fd-89b43abd7d0e
439b847c-bca8-40fd-a6f0-eb20958acd50	a307202a-b006-4cca-8fb8-5d053bc7659e
a307202a-b006-4cca-8fb8-5d053bc7659e	e9e3c714-fb36-4b71-aa7e-a65f84f04b5c
7a2f3ac4-6efc-489a-ab29-2570cd89a1b3	7d1fd4f8-8c50-48ea-bf8b-0e846052f0f8
ea29a635-4e34-458e-9459-b16a5f79ffc0	b01850b6-f87f-4611-b9d2-1727e2a5ccc2
85fb0bb8-768d-408c-b593-e3a4dabf7281	ef68427d-347e-4d1b-96e0-acaf813fecae
439b847c-bca8-40fd-a6f0-eb20958acd50	02b706f3-83c8-4174-aaa0-d8caef025762
439b847c-bca8-40fd-a6f0-eb20958acd50	bf01c475-8fb5-4a61-af15-61221e1b49c1
e1263000-ff71-42a9-8b80-b806e9fa2e5b	0ce17403-f5a8-4f9a-a4aa-f61a9d068144
e1263000-ff71-42a9-8b80-b806e9fa2e5b	96c4741a-5b7e-47bf-a15b-2d47904530a0
e1263000-ff71-42a9-8b80-b806e9fa2e5b	a3972634-1f17-48ce-8c1d-d45e803d12a6
e1263000-ff71-42a9-8b80-b806e9fa2e5b	fb77b673-dad2-4a59-b3f2-b6071f3d8b49
d32aa018-e3f5-4cff-839b-8b393fd10dec	d9f0265d-7b95-4455-832f-b43da488a280
d32aa018-e3f5-4cff-839b-8b393fd10dec	c44fd63c-5c00-4aec-8b7c-de554a4ddb12
52d30564-7412-497a-9f9d-f67e79dd4f3c	7493e289-edbd-4920-ab00-3b58d70bf1d8
d32aa018-e3f5-4cff-839b-8b393fd10dec	fb77b673-dad2-4a59-b3f2-b6071f3d8b49
d32aa018-e3f5-4cff-839b-8b393fd10dec	a3972634-1f17-48ce-8c1d-d45e803d12a6
d32aa018-e3f5-4cff-839b-8b393fd10dec	96c4741a-5b7e-47bf-a15b-2d47904530a0
d32aa018-e3f5-4cff-839b-8b393fd10dec	0ce17403-f5a8-4f9a-a4aa-f61a9d068144
52d30564-7412-497a-9f9d-f67e79dd4f3c	0ce17403-f5a8-4f9a-a4aa-f61a9d068144
52d30564-7412-497a-9f9d-f67e79dd4f3c	96c4741a-5b7e-47bf-a15b-2d47904530a0
52d30564-7412-497a-9f9d-f67e79dd4f3c	a3972634-1f17-48ce-8c1d-d45e803d12a6
52d30564-7412-497a-9f9d-f67e79dd4f3c	d9f0265d-7b95-4455-832f-b43da488a280
52d30564-7412-497a-9f9d-f67e79dd4f3c	c44fd63c-5c00-4aec-8b7c-de554a4ddb12
52d30564-7412-497a-9f9d-f67e79dd4f3c	fb77b673-dad2-4a59-b3f2-b6071f3d8b49
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
17c47aee-25ca-43b8-aa6a-04c3d249f426	\N	password	50c43acc-93e4-46ac-a7ab-048276d66a48	1631008191011	\N	{"value":"MkmywPs2ipWfl4ctFShRqaIrrqpDmalsyi/rwD8jzhZee7Ijv53H+ntaVlzgyRzW5cV57BqDVlr7i+yuVriaCA==","salt":"6AdUS22lb5+nZgrtBpSatQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
403f42bd-a365-46fe-b2eb-aae36951a772	\N	password	4b2fc7b8-a676-405e-92d3-4ff008e87b38	1631008609521	\N	{"value":"5MI0lo6dQim95BHlYds9KL8voG+4gOnqS99d4XFKup6xWXSsVW94cxzL9R0ZdDSIWe5OSoPgC2MbV1uL1Srsjw==","salt":"dDPsq0r7kUE5PMEjj7bKfQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
ab503012-3171-459c-8890-60e9461c07de	\N	password	576fff8a-8dcd-439b-af2f-e379a80be568	1631008636068	\N	{"value":"oK1glq300pUvZ94QoKXlLkl8alrywLlKoMGkxzqmDK3LNp2+iTpMa0dsK31zELqKXOXlZK/gmcixOhDjVhJmzQ==","salt":"k38tm740dHKVGf+7D3W5Xg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6c12b754-1e47-46db-9ee6-a1d5414ba3c5	\N	password	3e5ca7c0-0311-425c-aaca-2d88ad027b80	1631023888418	\N	{"value":"Dbve7NLJexFDgxqDfSzCp5hV3kZ5N0qESmRMGLYp/mqloaPWSfYqVj2o4a5moGaTWw1aLwy4IZy7zgAzbXDkuw==","salt":"PWSuIkf+ShyyB2W0JPZktg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
e1049673-d9d0-4389-aaba-da050bbee749	\N	password	c33e1d5b-d309-4932-b393-67b3044a4aec	1631783407977	\N	{"value":"V6bCID5LZtZzgahGS3fEhdN6QAaVc306usDDZ5zNt/r2ogS2YHG7nCAg/z3bEFfjCfaSlq5P2yrlF87ruEWt1w==","salt":"L29AHIBDvAN7aKoyIrw0QQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1a896c97-b53d-4220-8997-54ed6f7b203e	\N	password	76799a3e-131f-420d-b6b7-c130bad9d87e	1631784482578	\N	{"value":"4vykfROhwYZDoGm8nsny3Qx9Dcyo3LTiF5FgOAmVqSe2mlUjpBJu8y7Qqq1kbBEf9zdmGB+X/x8ye1Bn3VbaSg==","salt":"zTe6wrCGE55gitCiF4M0hQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2021-09-07 09:49:38.681275	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	1008177278
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2021-09-07 09:49:38.694727	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	1008177278
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2021-09-07 09:49:38.846953	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	1008177278
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2021-09-07 09:49:38.854756	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	1008177278
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2021-09-07 09:49:39.147621	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	1008177278
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2021-09-07 09:49:39.153829	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	1008177278
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2021-09-07 09:49:39.696662	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	1008177278
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2021-09-07 09:49:39.702997	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	1008177278
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2021-09-07 09:49:39.710086	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	1008177278
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2021-09-07 09:49:39.911692	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	1008177278
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2021-09-07 09:49:40.07844	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1008177278
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2021-09-07 09:49:40.094155	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1008177278
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2021-09-07 09:49:40.125966	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	1008177278
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-09-07 09:49:40.225989	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	1008177278
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-09-07 09:49:40.230395	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1008177278
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-09-07 09:49:40.234251	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	1008177278
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2021-09-07 09:49:40.238046	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	1008177278
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2021-09-07 09:49:40.375447	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	1008177278
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2021-09-07 09:49:40.676113	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	1008177278
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2021-09-07 09:49:40.685524	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	1008177278
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-09-07 09:49:43.638346	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	1008177278
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2021-09-07 09:49:40.691078	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	1008177278
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2021-09-07 09:49:40.695741	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	1008177278
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2021-09-07 09:49:40.816433	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	1008177278
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2021-09-07 09:49:40.82773	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	1008177278
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2021-09-07 09:49:40.832104	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	1008177278
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2021-09-07 09:49:41.268972	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	1008177278
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2021-09-07 09:49:41.664216	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	1008177278
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2021-09-07 09:49:41.671196	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	1008177278
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2021-09-07 09:49:41.850903	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	1008177278
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2021-09-07 09:49:41.976839	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	1008177278
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2021-09-07 09:49:42.015953	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	1008177278
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2021-09-07 09:49:42.02352	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	1008177278
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-09-07 09:49:42.033959	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1008177278
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-09-07 09:49:42.038156	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	1008177278
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-09-07 09:49:42.128871	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	1008177278
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2021-09-07 09:49:42.140134	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	1008177278
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2021-09-07 09:49:42.159757	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1008177278
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2021-09-07 09:49:42.167581	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	1008177278
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2021-09-07 09:49:42.175893	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	1008177278
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-09-07 09:49:42.180146	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	1008177278
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-09-07 09:49:42.184865	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	1008177278
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2021-09-07 09:49:42.192997	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	1008177278
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2021-09-07 09:49:43.620115	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	1008177278
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2021-09-07 09:49:43.62959	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	1008177278
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-09-07 09:49:43.645404	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	1008177278
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-09-07 09:49:43.649385	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	1008177278
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-09-07 09:49:43.774454	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	1008177278
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2021-09-07 09:49:43.791315	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	1008177278
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2021-09-07 09:49:43.920724	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	1008177278
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2021-09-07 09:49:44.220108	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	1008177278
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2021-09-07 09:49:44.22734	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1008177278
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2021-09-07 09:49:44.232093	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	1008177278
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2021-09-07 09:49:44.237001	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	1008177278
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-09-07 09:49:44.249983	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	1008177278
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-09-07 09:49:44.258602	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	1008177278
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-09-07 09:49:44.362995	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	1008177278
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2021-09-07 09:49:44.760306	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	1008177278
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2021-09-07 09:49:44.865367	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	1008177278
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2021-09-07 09:49:44.875857	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	1008177278
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-09-07 09:49:44.889168	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	1008177278
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2021-09-07 09:49:44.902704	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	1008177278
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2021-09-07 09:49:44.909567	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	1008177278
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2021-09-07 09:49:44.914595	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	1008177278
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2021-09-07 09:49:44.919472	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	1008177278
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2021-09-07 09:49:44.985038	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	1008177278
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2021-09-07 09:49:45.014372	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	1008177278
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2021-09-07 09:49:45.024101	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	1008177278
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2021-09-07 09:49:45.058326	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	1008177278
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2021-09-07 09:49:45.068175	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	1008177278
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2021-09-07 09:49:45.076126	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	1008177278
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-09-07 09:49:45.086124	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1008177278
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-09-07 09:49:45.094896	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1008177278
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-09-07 09:49:45.099036	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	1008177278
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-09-07 09:49:45.137843	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	1008177278
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2021-09-07 09:49:45.199857	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	1008177278
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-09-07 09:49:45.209993	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	1008177278
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-09-07 09:49:45.214475	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	1008177278
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-09-07 09:49:45.248752	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	1008177278
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2021-09-07 09:49:45.253327	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	1008177278
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-09-07 09:49:45.286922	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	1008177278
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-09-07 09:49:45.2949	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1008177278
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-09-07 09:49:45.304529	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1008177278
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-09-07 09:49:45.30851	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	1008177278
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2021-09-07 09:49:45.350673	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	1008177278
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2021-09-07 09:49:45.360419	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	1008177278
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-09-07 09:49:45.374605	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	1008177278
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2021-09-07 09:49:45.403509	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	1008177278
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.414409	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	1008177278
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.427455	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	1008177278
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.473925	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1008177278
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.491313	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	1008177278
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.495716	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	1008177278
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.517051	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	1008177278
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.521782	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	1008177278
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2021-09-07 09:49:45.532229	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	1008177278
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.615519	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	1008177278
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.620168	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1008177278
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.631977	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1008177278
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.667351	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1008177278
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.672272	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	1008177278
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.710299	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	1008177278
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2021-09-07 09:49:45.717674	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	1008177278
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2021-09-07 09:49:45.726437	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	1008177278
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	55a72f45-f3dc-490f-8830-b07d8aa0432d	f
master	bd8eaf25-b498-455c-9a59-78925422ce3c	t
master	f5997fab-8c37-4c29-a46e-7a9659c634e3	t
master	09a2727e-9d9b-463e-afc7-034822737a20	t
master	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0	f
master	8bc4663e-a2b7-4f40-88aa-907cc2d39e85	f
master	7ed4c7bc-fb80-4494-82d2-72791ae671cc	t
master	3690a443-3b92-46ce-967b-7548b34a1019	t
master	566cc8c6-a43d-4a36-bda6-5c742f636ce5	f
worldcereal	f688e83d-a1c6-4ec7-9b5a-cd912cfd82cb	f
worldcereal	2643d4ef-f875-4f88-b231-9cdc89ac9a09	t
worldcereal	59824934-f46d-474f-a560-b0f01ff24060	t
worldcereal	c7fedcc6-3bbf-4c42-9dc0-b177212460d5	t
worldcereal	90635ebf-9832-4048-b269-bce7874b8d9e	f
worldcereal	f4a5dcd4-10a6-4e24-bf15-26ada44be330	f
worldcereal	173db783-b6d3-4ff9-841f-236866bf5746	t
worldcereal	1d6717fb-659c-4b89-a2e2-f65c6719e6c3	t
worldcereal	f8b0f5dd-d33f-4339-a677-72a93242bf99	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
52d30564-7412-497a-9f9d-f67e79dd4f3c	ed99f498-dd9e-4506-b60a-015b22c97817
d32aa018-e3f5-4cff-839b-8b393fd10dec	e5b2afdb-ee74-44e0-8ce2-9d13e673a361
e1263000-ff71-42a9-8b80-b806e9fa2e5b	258b4159-6c6c-4b60-ba83-af0991aa23f1
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
e5b2afdb-ee74-44e0-8ce2-9d13e673a361	ewoc_admin	 	worldcereal
258b4159-6c6c-4b60-ba83-af0991aa23f1	ewoc_user	 	worldcereal
ed99f498-dd9e-4506-b60a-015b22c97817	ewoc_platform_admin	 	worldcereal
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
b29eb198-4a7d-4930-84a8-20097bdc64a6	master	f	${role_default-roles}	default-roles-master	master	\N	\N
ea29a635-4e34-458e-9459-b16a5f79ffc0	master	f	${role_admin}	admin	master	\N	\N
bdc17c21-733c-4acb-8b7b-993c6b466a45	master	f	${role_create-realm}	create-realm	master	\N	\N
d68c9db3-b9b6-4df9-a2f5-961b70919f29	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_create-client}	create-client	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
d8661d38-8530-40fe-b501-45d20f91a9c5	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-realm}	view-realm	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
f25fe4f7-9ebc-44b2-8e5d-a1814ea0e825	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-users}	view-users	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
42e663b2-b193-4ba9-9e09-2f6e3acc6a6b	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-clients}	view-clients	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
7fa725bc-9a7d-490a-8a19-e048bf58a410	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-events}	view-events	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
7e2d9320-0c2d-4f30-9b37-a8149323eaa2	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-identity-providers}	view-identity-providers	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
eb45662a-924b-4c67-ad3e-8feba489614b	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_view-authorization}	view-authorization	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
982f8761-0258-4a21-8844-5e164997f697	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-realm}	manage-realm	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
c4e950d5-bddf-4895-9c6b-ceda6870ef76	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-users}	manage-users	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
cd73ff6f-033b-4d8c-b2a9-7c3719614d2d	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-clients}	manage-clients	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
5ae323fb-89a1-49fe-88ac-1990acc2f5c9	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-events}	manage-events	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
378a92c2-c1b1-4d9f-a0ab-16443f03c3be	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-identity-providers}	manage-identity-providers	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
ad100d91-9d47-46d4-908b-ed1adc7e9810	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_manage-authorization}	manage-authorization	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
26eb316b-d953-4cd0-8a9b-398086ddacb9	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_query-users}	query-users	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
4ef22280-a8bd-49e1-86bc-9ca3057abcb6	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_query-clients}	query-clients	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
cb62a86c-2527-4af2-840b-6a0058ac8ce3	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_query-realms}	query-realms	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
c5d73ccb-5a0e-4130-86db-24a44750c5b3	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_query-groups}	query-groups	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
85586b7d-3062-4230-9539-42b682652d66	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_view-profile}	view-profile	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
b51a10bc-c877-46d2-a1e2-7453c13eea8b	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_manage-account}	manage-account	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
32cefccf-a74b-418e-925a-d1bff2be5f25	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_manage-account-links}	manage-account-links	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
64ec4eea-3def-4593-93ed-85edd2baac4f	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_view-applications}	view-applications	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
b8699a36-1c50-42be-83f5-66a3f0f630f4	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_view-consent}	view-consent	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
cf0278a0-f475-4950-b3d9-23b6d11f3d6a	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_manage-consent}	manage-consent	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
63463a8d-0a30-47f7-8157-ab8efe28bd14	72b3aa15-a699-4ff4-aa82-347837b1d306	t	${role_delete-account}	delete-account	master	72b3aa15-a699-4ff4-aa82-347837b1d306	\N
abaa9a42-37ee-4ebd-9b4f-9e6e50a057a1	28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	t	${role_read-token}	read-token	master	28748be5-2df0-47ee-8c98-a3c3e9cf0bdf	\N
6f7d741f-04aa-4710-bdd8-e440c777f6b0	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	t	${role_impersonation}	impersonation	master	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	\N
8a961bf3-33b2-4152-895a-8f66f9ee2eae	master	f	${role_offline-access}	offline_access	master	\N	\N
2c0e14ef-6acf-46dc-ba46-746f5ada0eef	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
439b847c-bca8-40fd-a6f0-eb20958acd50	worldcereal	f	${role_default-roles}	default-roles-worldcereal	worldcereal	\N	\N
8e026a80-9c12-4aba-813a-e532da7d5a8b	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_create-client}	create-client	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
3fc2526a-630a-4e66-a5ed-e9d064513561	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-realm}	view-realm	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
2f402c87-39fa-440d-b03b-966b3f85694c	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-users}	view-users	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
56cfaa43-b4df-4e2b-8a0f-2503013ad650	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-clients}	view-clients	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
cb481723-c7a1-486b-b50e-6f8aa61f9603	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-events}	view-events	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
ab813679-58d4-4b16-a3ae-1c01a187678e	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-identity-providers}	view-identity-providers	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
fdf02ae8-bcc1-42ed-b1d9-de5b7b128619	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_view-authorization}	view-authorization	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
44ae2542-d762-49d5-af41-05e279167e77	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-realm}	manage-realm	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
e0904c9a-c68c-496e-9fc2-dd170ae59846	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-users}	manage-users	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
bf7dc6e2-e666-4023-98f3-8272e6ff4700	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-clients}	manage-clients	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
0101b97d-3dde-4f5b-9331-05e0a9cdcc25	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-events}	manage-events	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
194bbf48-e30c-4f8d-bf89-cbe4b154faf0	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-identity-providers}	manage-identity-providers	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
fa9c5305-00a6-4f3f-ac99-822af41687fb	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_manage-authorization}	manage-authorization	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
04d83ca1-9763-4f28-9b3f-2a682e7b6929	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_query-users}	query-users	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
192c8137-1b30-42a2-877c-09f1a2daa490	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_query-clients}	query-clients	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
3792875b-efb2-40f4-aad8-748f84b81aef	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_query-realms}	query-realms	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
164d9a8d-6e19-4867-a451-3c6910dd599f	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_query-groups}	query-groups	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
85fb0bb8-768d-408c-b593-e3a4dabf7281	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_realm-admin}	realm-admin	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
b7053a20-71b1-4383-8fb0-8f21b7d35bbe	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_create-client}	create-client	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
f13df049-cf47-46ca-b295-9c9ec27dcd3b	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-realm}	view-realm	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
2c0523e5-9a9c-43f0-8451-815968afda95	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-users}	view-users	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
b0df074e-3179-4e18-8772-31d3679d7bb1	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-clients}	view-clients	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
0e69c95a-deb3-4a94-955a-0c80f717ae09	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-events}	view-events	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
d49e6ff6-be68-4c14-a88b-bbf776c60768	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-identity-providers}	view-identity-providers	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
b14a1f7e-3793-4106-b271-c3395ab511f9	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_view-authorization}	view-authorization	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
0cc8bf7e-72bd-4d40-ad8b-e6a23e8f6206	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-realm}	manage-realm	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
9696fe12-1886-49bb-81cf-bf3644a3b533	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-users}	manage-users	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
8518f31f-a672-439b-b8d8-9e480544674c	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-clients}	manage-clients	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
c5302c46-3220-4977-aa07-dd089c857ed5	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-events}	manage-events	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
d006f0bf-7880-456f-aa68-0c2b1ffffd96	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-identity-providers}	manage-identity-providers	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
b9d31279-7e21-41ee-8557-c8bdcf5961b2	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_manage-authorization}	manage-authorization	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
54293a2f-7098-4149-9346-1f3434841cf1	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_query-users}	query-users	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
50465b19-118b-4f90-92c8-850cd5a2903b	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_query-clients}	query-clients	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
467e7046-9ba4-4904-b2a4-0fa269eafd1c	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_query-realms}	query-realms	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
468b3de4-10a5-44fb-b7aa-0c210a722c84	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_query-groups}	query-groups	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
70f8ed59-d8ad-4227-91fd-89b43abd7d0e	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_view-profile}	view-profile	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
a307202a-b006-4cca-8fb8-5d053bc7659e	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_manage-account}	manage-account	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
e9e3c714-fb36-4b71-aa7e-a65f84f04b5c	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_manage-account-links}	manage-account-links	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
f07f0360-85cf-45e4-a7eb-1eb3cb25d6d3	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_view-applications}	view-applications	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
7d1fd4f8-8c50-48ea-bf8b-0e846052f0f8	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_view-consent}	view-consent	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
7a2f3ac4-6efc-489a-ab29-2570cd89a1b3	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_manage-consent}	manage-consent	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
7ce6a746-26da-42c9-bfa0-eb2b0f8dfe46	ad27c24a-448f-4f43-9a00-2437cd7053bd	t	${role_delete-account}	delete-account	worldcereal	ad27c24a-448f-4f43-9a00-2437cd7053bd	\N
b01850b6-f87f-4611-b9d2-1727e2a5ccc2	c2752f7b-34b4-4043-9945-0feb050e621f	t	${role_impersonation}	impersonation	master	c2752f7b-34b4-4043-9945-0feb050e621f	\N
ef68427d-347e-4d1b-96e0-acaf813fecae	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	t	${role_impersonation}	impersonation	worldcereal	3d1be7d9-2a17-4a96-b9a5-dea2ef1dbad0	\N
aba13a23-150d-4962-82ba-6fbeeee59285	85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	t	${role_read-token}	read-token	worldcereal	85baedfa-a3c4-4bbd-961f-eb2c4bc43c52	\N
02b706f3-83c8-4174-aaa0-d8caef025762	worldcereal	f	${role_offline-access}	offline_access	worldcereal	\N	\N
bf01c475-8fb5-4a61-af15-61221e1b49c1	worldcereal	f	${role_uma_authorization}	uma_authorization	worldcereal	\N	\N
7493e289-edbd-4920-ab00-3b58d70bf1d8	935a293a-122f-43e2-b4a9-c57ff38e326a	t	\N	prometheus_role	worldcereal	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
d9f0265d-7b95-4455-832f-b43da488a280	fc85da61-1851-4ea0-9ee4-38d6bd0c71de	t	\N	grafana_role	worldcereal	fc85da61-1851-4ea0-9ee4-38d6bd0c71de	\N
e1263000-ff71-42a9-8b80-b806e9fa2e5b	worldcereal	f	Acces only to: RDM, WCTiller, Processing , Vizualization and Dissemination module.	user	worldcereal	\N	\N
d32aa018-e3f5-4cff-839b-8b393fd10dec	worldcereal	f	Access to monitoring  logs and metrics (Graylog & Grafana) in addition user role.	admin	worldcereal	\N	\N
52d30564-7412-497a-9f9d-f67e79dd4f3c	worldcereal	f	Acces to All module on the platform.	super_admin	worldcereal	\N	\N
c44fd63c-5c00-4aec-8b7c-de554a4ddb12	ef1a9afd-41f2-4eaf-9813-48873052101e	t	\N	graylog_role	worldcereal	ef1a9afd-41f2-4eaf-9813-48873052101e	\N
a3972634-1f17-48ce-8c1d-d45e803d12a6	cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	t	\N	rdm_role	worldcereal	cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	\N
96c4741a-5b7e-47bf-a15b-2d47904530a0	5981bec6-31e5-44aa-aa76-f9815198f954	t	\N	processing_role	worldcereal	5981bec6-31e5-44aa-aa76-f9815198f954	\N
fb77b673-dad2-4a59-b3f2-b6071f3d8b49	f07d4e4b-371b-47db-867c-21a1853a25da	t	\N	wctiler_role	worldcereal	f07d4e4b-371b-47db-867c-21a1853a25da	\N
0ce17403-f5a8-4f9a-a4aa-f61a9d068144	38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	t	\N	dissemination_role	worldcereal	38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ga06o	15.0.2	1631008188
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
7dc585c1-c6a6-4a3c-a6f9-886f2c971dda	audience resolve	openid-connect	oidc-audience-resolve-mapper	362ed1e8-1d67-4d7d-9c4c-200636c32d33	\N
49096fcf-a444-4aef-aa3b-66f1e66df927	locale	openid-connect	oidc-usermodel-attribute-mapper	7468cf99-e160-4c11-9770-12735d71e383	\N
4b374587-f56d-4bd1-bf0d-950a34580a2a	role list	saml	saml-role-list-mapper	\N	bd8eaf25-b498-455c-9a59-78925422ce3c
461a16cf-62eb-453d-8e9c-05c3e54312ce	full name	openid-connect	oidc-full-name-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
07521d7b-3ce4-4220-8f01-4d11c5621233	family name	openid-connect	oidc-usermodel-property-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
a3b77dbd-0847-4672-814a-842a3c9b6cad	given name	openid-connect	oidc-usermodel-property-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
a69c1aba-b7b0-4098-907c-17c581d410e4	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
52222bfd-5417-45b4-a006-cde9dce829fa	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
398d266f-881f-4e95-abe4-c478d7c152d4	username	openid-connect	oidc-usermodel-property-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
d126c9b9-f335-4573-9b6e-90fb30469e22	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
dccff579-55c5-40f0-9604-d808f926ba8c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
f22374fb-bd3c-41b8-90a1-e57a6186e064	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
7ebfed92-5a62-4131-b9da-435e95bb19be	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
63cca2c2-b2cc-4616-9e10-931f0e070b30	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f5997fab-8c37-4c29-a46e-7a9659c634e3
b8b0c246-c0f3-4193-b94c-d2a35785fde0	email	openid-connect	oidc-usermodel-property-mapper	\N	09a2727e-9d9b-463e-afc7-034822737a20
5ea2824f-0a64-4a5e-b408-d56fe5f69962	email verified	openid-connect	oidc-usermodel-property-mapper	\N	09a2727e-9d9b-463e-afc7-034822737a20
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	address	openid-connect	oidc-address-mapper	\N	4bf11e16-096f-45e7-b5ce-6c6ef2a8d2d0
36f82553-e85c-4541-bc09-97e328928961	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	8bc4663e-a2b7-4f40-88aa-907cc2d39e85
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	8bc4663e-a2b7-4f40-88aa-907cc2d39e85
2402f838-f269-4d01-98c6-80702921d363	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7ed4c7bc-fb80-4494-82d2-72791ae671cc
22648220-0977-48b2-8bdf-5a12814bae4b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7ed4c7bc-fb80-4494-82d2-72791ae671cc
cd757f75-ed61-422a-baf0-9421302cc0a3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7ed4c7bc-fb80-4494-82d2-72791ae671cc
819f7902-3d60-4067-b18b-0405fa9a20bf	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	3690a443-3b92-46ce-967b-7548b34a1019
22091dbf-567a-4f95-87c2-17ddce6e64b0	upn	openid-connect	oidc-usermodel-property-mapper	\N	566cc8c6-a43d-4a36-bda6-5c742f636ce5
b364af5f-0e79-402d-8690-f0425f8ad497	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	566cc8c6-a43d-4a36-bda6-5c742f636ce5
4c5731ef-47a0-48d3-8360-471ef65bc195	audience resolve	openid-connect	oidc-audience-resolve-mapper	ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	\N
6bd43073-188a-41ea-a002-10d1cda85063	role list	saml	saml-role-list-mapper	\N	2643d4ef-f875-4f88-b231-9cdc89ac9a09
8eedd34b-a810-4211-a308-64e9928ba7da	full name	openid-connect	oidc-full-name-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
8be91871-16b4-4848-88e5-60dc6bbe2c77	family name	openid-connect	oidc-usermodel-property-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
8ed6305a-4bc1-4fad-a121-35846c029e9d	given name	openid-connect	oidc-usermodel-property-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
14861fe0-73da-49a5-952b-87b19dc90167	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
b5947d27-c4bd-44bd-8703-30eed88c99ec	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	username	openid-connect	oidc-usermodel-property-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
8fb6175f-f393-438d-af03-1a639c4d5132	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	website	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
5c445927-5197-4aff-a5c1-e2df3038cf4a	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
dd54beda-3f2c-47e7-b973-62379df8ae9f	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
b57ef259-6dd5-497b-a33f-75ae9e203f2c	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	59824934-f46d-474f-a560-b0f01ff24060
c42c9276-60a2-487e-950a-91b4fef85d16	email	openid-connect	oidc-usermodel-property-mapper	\N	c7fedcc6-3bbf-4c42-9dc0-b177212460d5
86de1943-d49c-43d8-a4d6-192e0cca249e	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c7fedcc6-3bbf-4c42-9dc0-b177212460d5
8e0ac251-7805-4c60-98e8-b40e0204f01e	address	openid-connect	oidc-address-mapper	\N	90635ebf-9832-4048-b269-bce7874b8d9e
f1fa68f8-f7fd-4271-9b14-1824af168bc8	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f4a5dcd4-10a6-4e24-bf15-26ada44be330
59bb934e-a685-4740-9b14-819045555a83	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f4a5dcd4-10a6-4e24-bf15-26ada44be330
d87b8c8a-55b4-46de-b508-75a4c9e6b271	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	173db783-b6d3-4ff9-841f-236866bf5746
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	173db783-b6d3-4ff9-841f-236866bf5746
b125f411-86f0-4caf-b3d8-fdab0eec8d1e	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	173db783-b6d3-4ff9-841f-236866bf5746
2f24e140-9365-45e5-85ac-79c4122e593e	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1d6717fb-659c-4b89-a2e2-f65c6719e6c3
6416d1ed-1157-4b97-84dc-2183c2983676	upn	openid-connect	oidc-usermodel-property-mapper	\N	f8b0f5dd-d33f-4339-a677-72a93242bf99
cc556f0b-a0b2-450a-b80d-3c308b135c37	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f8b0f5dd-d33f-4339-a677-72a93242bf99
ed36c7b2-457a-45b1-bf61-3c6592fe9146	locale	openid-connect	oidc-usermodel-attribute-mapper	285a7567-b365-4999-81ec-470646e1554e	\N
ee82dd26-3389-4a90-b742-f7c8728fc2a9	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
af95a884-7ae9-4d83-925b-2d91fee52666	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
a6e609df-f590-46bb-9cb3-2e340891c60d	User group	openid-connect	oidc-group-membership-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	User Attribute mapper	openid-connect	oidc-usermodel-attribute-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	username	openid-connect	oidc-usermodel-property-mapper	935a293a-122f-43e2-b4a9-c57ff38e326a	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
49096fcf-a444-4aef-aa3b-66f1e66df927	true	userinfo.token.claim
49096fcf-a444-4aef-aa3b-66f1e66df927	locale	user.attribute
49096fcf-a444-4aef-aa3b-66f1e66df927	true	id.token.claim
49096fcf-a444-4aef-aa3b-66f1e66df927	true	access.token.claim
49096fcf-a444-4aef-aa3b-66f1e66df927	locale	claim.name
49096fcf-a444-4aef-aa3b-66f1e66df927	String	jsonType.label
4b374587-f56d-4bd1-bf0d-950a34580a2a	false	single
4b374587-f56d-4bd1-bf0d-950a34580a2a	Basic	attribute.nameformat
4b374587-f56d-4bd1-bf0d-950a34580a2a	Role	attribute.name
461a16cf-62eb-453d-8e9c-05c3e54312ce	true	userinfo.token.claim
461a16cf-62eb-453d-8e9c-05c3e54312ce	true	id.token.claim
461a16cf-62eb-453d-8e9c-05c3e54312ce	true	access.token.claim
07521d7b-3ce4-4220-8f01-4d11c5621233	true	userinfo.token.claim
07521d7b-3ce4-4220-8f01-4d11c5621233	lastName	user.attribute
07521d7b-3ce4-4220-8f01-4d11c5621233	true	id.token.claim
07521d7b-3ce4-4220-8f01-4d11c5621233	true	access.token.claim
07521d7b-3ce4-4220-8f01-4d11c5621233	family_name	claim.name
07521d7b-3ce4-4220-8f01-4d11c5621233	String	jsonType.label
a3b77dbd-0847-4672-814a-842a3c9b6cad	true	userinfo.token.claim
a3b77dbd-0847-4672-814a-842a3c9b6cad	firstName	user.attribute
a3b77dbd-0847-4672-814a-842a3c9b6cad	true	id.token.claim
a3b77dbd-0847-4672-814a-842a3c9b6cad	true	access.token.claim
a3b77dbd-0847-4672-814a-842a3c9b6cad	given_name	claim.name
a3b77dbd-0847-4672-814a-842a3c9b6cad	String	jsonType.label
a69c1aba-b7b0-4098-907c-17c581d410e4	true	userinfo.token.claim
a69c1aba-b7b0-4098-907c-17c581d410e4	middleName	user.attribute
a69c1aba-b7b0-4098-907c-17c581d410e4	true	id.token.claim
a69c1aba-b7b0-4098-907c-17c581d410e4	true	access.token.claim
a69c1aba-b7b0-4098-907c-17c581d410e4	middle_name	claim.name
a69c1aba-b7b0-4098-907c-17c581d410e4	String	jsonType.label
52222bfd-5417-45b4-a006-cde9dce829fa	true	userinfo.token.claim
52222bfd-5417-45b4-a006-cde9dce829fa	nickname	user.attribute
52222bfd-5417-45b4-a006-cde9dce829fa	true	id.token.claim
52222bfd-5417-45b4-a006-cde9dce829fa	true	access.token.claim
52222bfd-5417-45b4-a006-cde9dce829fa	nickname	claim.name
52222bfd-5417-45b4-a006-cde9dce829fa	String	jsonType.label
398d266f-881f-4e95-abe4-c478d7c152d4	true	userinfo.token.claim
398d266f-881f-4e95-abe4-c478d7c152d4	username	user.attribute
398d266f-881f-4e95-abe4-c478d7c152d4	true	id.token.claim
398d266f-881f-4e95-abe4-c478d7c152d4	true	access.token.claim
398d266f-881f-4e95-abe4-c478d7c152d4	preferred_username	claim.name
398d266f-881f-4e95-abe4-c478d7c152d4	String	jsonType.label
d126c9b9-f335-4573-9b6e-90fb30469e22	true	userinfo.token.claim
d126c9b9-f335-4573-9b6e-90fb30469e22	profile	user.attribute
d126c9b9-f335-4573-9b6e-90fb30469e22	true	id.token.claim
d126c9b9-f335-4573-9b6e-90fb30469e22	true	access.token.claim
d126c9b9-f335-4573-9b6e-90fb30469e22	profile	claim.name
d126c9b9-f335-4573-9b6e-90fb30469e22	String	jsonType.label
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	true	userinfo.token.claim
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	picture	user.attribute
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	true	id.token.claim
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	true	access.token.claim
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	picture	claim.name
22a2aabf-a6b9-4b2d-b95c-81832a3ea166	String	jsonType.label
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	true	userinfo.token.claim
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	website	user.attribute
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	true	id.token.claim
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	true	access.token.claim
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	website	claim.name
424dd9fd-c8aa-474d-a2c5-5ea58db23d0b	String	jsonType.label
dccff579-55c5-40f0-9604-d808f926ba8c	true	userinfo.token.claim
dccff579-55c5-40f0-9604-d808f926ba8c	gender	user.attribute
dccff579-55c5-40f0-9604-d808f926ba8c	true	id.token.claim
dccff579-55c5-40f0-9604-d808f926ba8c	true	access.token.claim
dccff579-55c5-40f0-9604-d808f926ba8c	gender	claim.name
dccff579-55c5-40f0-9604-d808f926ba8c	String	jsonType.label
f22374fb-bd3c-41b8-90a1-e57a6186e064	true	userinfo.token.claim
f22374fb-bd3c-41b8-90a1-e57a6186e064	birthdate	user.attribute
f22374fb-bd3c-41b8-90a1-e57a6186e064	true	id.token.claim
f22374fb-bd3c-41b8-90a1-e57a6186e064	true	access.token.claim
f22374fb-bd3c-41b8-90a1-e57a6186e064	birthdate	claim.name
f22374fb-bd3c-41b8-90a1-e57a6186e064	String	jsonType.label
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	true	userinfo.token.claim
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	zoneinfo	user.attribute
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	true	id.token.claim
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	true	access.token.claim
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	zoneinfo	claim.name
e6433ebe-8275-4d40-8f50-c1f2527f1e5d	String	jsonType.label
7ebfed92-5a62-4131-b9da-435e95bb19be	true	userinfo.token.claim
7ebfed92-5a62-4131-b9da-435e95bb19be	locale	user.attribute
7ebfed92-5a62-4131-b9da-435e95bb19be	true	id.token.claim
7ebfed92-5a62-4131-b9da-435e95bb19be	true	access.token.claim
7ebfed92-5a62-4131-b9da-435e95bb19be	locale	claim.name
7ebfed92-5a62-4131-b9da-435e95bb19be	String	jsonType.label
63cca2c2-b2cc-4616-9e10-931f0e070b30	true	userinfo.token.claim
63cca2c2-b2cc-4616-9e10-931f0e070b30	updatedAt	user.attribute
63cca2c2-b2cc-4616-9e10-931f0e070b30	true	id.token.claim
63cca2c2-b2cc-4616-9e10-931f0e070b30	true	access.token.claim
63cca2c2-b2cc-4616-9e10-931f0e070b30	updated_at	claim.name
63cca2c2-b2cc-4616-9e10-931f0e070b30	String	jsonType.label
b8b0c246-c0f3-4193-b94c-d2a35785fde0	true	userinfo.token.claim
b8b0c246-c0f3-4193-b94c-d2a35785fde0	email	user.attribute
b8b0c246-c0f3-4193-b94c-d2a35785fde0	true	id.token.claim
b8b0c246-c0f3-4193-b94c-d2a35785fde0	true	access.token.claim
b8b0c246-c0f3-4193-b94c-d2a35785fde0	email	claim.name
b8b0c246-c0f3-4193-b94c-d2a35785fde0	String	jsonType.label
5ea2824f-0a64-4a5e-b408-d56fe5f69962	true	userinfo.token.claim
5ea2824f-0a64-4a5e-b408-d56fe5f69962	emailVerified	user.attribute
5ea2824f-0a64-4a5e-b408-d56fe5f69962	true	id.token.claim
5ea2824f-0a64-4a5e-b408-d56fe5f69962	true	access.token.claim
5ea2824f-0a64-4a5e-b408-d56fe5f69962	email_verified	claim.name
5ea2824f-0a64-4a5e-b408-d56fe5f69962	boolean	jsonType.label
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	formatted	user.attribute.formatted
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	country	user.attribute.country
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	postal_code	user.attribute.postal_code
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	true	userinfo.token.claim
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	street	user.attribute.street
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	true	id.token.claim
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	region	user.attribute.region
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	true	access.token.claim
2222e1d3-e9a2-4dd1-826d-dc3604da5b9c	locality	user.attribute.locality
36f82553-e85c-4541-bc09-97e328928961	true	userinfo.token.claim
36f82553-e85c-4541-bc09-97e328928961	phoneNumber	user.attribute
36f82553-e85c-4541-bc09-97e328928961	true	id.token.claim
36f82553-e85c-4541-bc09-97e328928961	true	access.token.claim
36f82553-e85c-4541-bc09-97e328928961	phone_number	claim.name
36f82553-e85c-4541-bc09-97e328928961	String	jsonType.label
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	true	userinfo.token.claim
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	phoneNumberVerified	user.attribute
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	true	id.token.claim
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	true	access.token.claim
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	phone_number_verified	claim.name
de0d7b76-63ac-44ed-8eaa-86bf3d9ccfd6	boolean	jsonType.label
2402f838-f269-4d01-98c6-80702921d363	true	multivalued
2402f838-f269-4d01-98c6-80702921d363	foo	user.attribute
2402f838-f269-4d01-98c6-80702921d363	true	access.token.claim
2402f838-f269-4d01-98c6-80702921d363	realm_access.roles	claim.name
2402f838-f269-4d01-98c6-80702921d363	String	jsonType.label
22648220-0977-48b2-8bdf-5a12814bae4b	true	multivalued
22648220-0977-48b2-8bdf-5a12814bae4b	foo	user.attribute
22648220-0977-48b2-8bdf-5a12814bae4b	true	access.token.claim
22648220-0977-48b2-8bdf-5a12814bae4b	resource_access.${client_id}.roles	claim.name
22648220-0977-48b2-8bdf-5a12814bae4b	String	jsonType.label
22091dbf-567a-4f95-87c2-17ddce6e64b0	true	userinfo.token.claim
22091dbf-567a-4f95-87c2-17ddce6e64b0	username	user.attribute
22091dbf-567a-4f95-87c2-17ddce6e64b0	true	id.token.claim
22091dbf-567a-4f95-87c2-17ddce6e64b0	true	access.token.claim
22091dbf-567a-4f95-87c2-17ddce6e64b0	upn	claim.name
22091dbf-567a-4f95-87c2-17ddce6e64b0	String	jsonType.label
b364af5f-0e79-402d-8690-f0425f8ad497	true	multivalued
b364af5f-0e79-402d-8690-f0425f8ad497	foo	user.attribute
b364af5f-0e79-402d-8690-f0425f8ad497	true	id.token.claim
b364af5f-0e79-402d-8690-f0425f8ad497	true	access.token.claim
b364af5f-0e79-402d-8690-f0425f8ad497	groups	claim.name
b364af5f-0e79-402d-8690-f0425f8ad497	String	jsonType.label
6bd43073-188a-41ea-a002-10d1cda85063	false	single
6bd43073-188a-41ea-a002-10d1cda85063	Basic	attribute.nameformat
6bd43073-188a-41ea-a002-10d1cda85063	Role	attribute.name
8eedd34b-a810-4211-a308-64e9928ba7da	true	userinfo.token.claim
8eedd34b-a810-4211-a308-64e9928ba7da	true	id.token.claim
8eedd34b-a810-4211-a308-64e9928ba7da	true	access.token.claim
8be91871-16b4-4848-88e5-60dc6bbe2c77	true	userinfo.token.claim
8be91871-16b4-4848-88e5-60dc6bbe2c77	lastName	user.attribute
8be91871-16b4-4848-88e5-60dc6bbe2c77	true	id.token.claim
8be91871-16b4-4848-88e5-60dc6bbe2c77	true	access.token.claim
8be91871-16b4-4848-88e5-60dc6bbe2c77	family_name	claim.name
8be91871-16b4-4848-88e5-60dc6bbe2c77	String	jsonType.label
8ed6305a-4bc1-4fad-a121-35846c029e9d	true	userinfo.token.claim
8ed6305a-4bc1-4fad-a121-35846c029e9d	firstName	user.attribute
8ed6305a-4bc1-4fad-a121-35846c029e9d	true	id.token.claim
8ed6305a-4bc1-4fad-a121-35846c029e9d	true	access.token.claim
8ed6305a-4bc1-4fad-a121-35846c029e9d	given_name	claim.name
8ed6305a-4bc1-4fad-a121-35846c029e9d	String	jsonType.label
14861fe0-73da-49a5-952b-87b19dc90167	true	userinfo.token.claim
14861fe0-73da-49a5-952b-87b19dc90167	middleName	user.attribute
14861fe0-73da-49a5-952b-87b19dc90167	true	id.token.claim
14861fe0-73da-49a5-952b-87b19dc90167	true	access.token.claim
14861fe0-73da-49a5-952b-87b19dc90167	middle_name	claim.name
14861fe0-73da-49a5-952b-87b19dc90167	String	jsonType.label
b5947d27-c4bd-44bd-8703-30eed88c99ec	true	userinfo.token.claim
b5947d27-c4bd-44bd-8703-30eed88c99ec	nickname	user.attribute
b5947d27-c4bd-44bd-8703-30eed88c99ec	true	id.token.claim
b5947d27-c4bd-44bd-8703-30eed88c99ec	true	access.token.claim
b5947d27-c4bd-44bd-8703-30eed88c99ec	nickname	claim.name
b5947d27-c4bd-44bd-8703-30eed88c99ec	String	jsonType.label
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	true	userinfo.token.claim
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	username	user.attribute
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	true	id.token.claim
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	true	access.token.claim
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	preferred_username	claim.name
3ea11b94-b0d8-447a-8d39-e19c0f5cd18a	String	jsonType.label
8fb6175f-f393-438d-af03-1a639c4d5132	true	userinfo.token.claim
8fb6175f-f393-438d-af03-1a639c4d5132	profile	user.attribute
8fb6175f-f393-438d-af03-1a639c4d5132	true	id.token.claim
8fb6175f-f393-438d-af03-1a639c4d5132	true	access.token.claim
8fb6175f-f393-438d-af03-1a639c4d5132	profile	claim.name
8fb6175f-f393-438d-af03-1a639c4d5132	String	jsonType.label
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	true	userinfo.token.claim
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	picture	user.attribute
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	true	id.token.claim
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	true	access.token.claim
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	picture	claim.name
8b4ef15a-3e34-4efb-a208-2d5c2b4a84ad	String	jsonType.label
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	true	userinfo.token.claim
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	website	user.attribute
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	true	id.token.claim
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	true	access.token.claim
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	website	claim.name
75a69c86-ea42-4353-b786-0cfb5e9dc5b1	String	jsonType.label
5c445927-5197-4aff-a5c1-e2df3038cf4a	true	userinfo.token.claim
5c445927-5197-4aff-a5c1-e2df3038cf4a	gender	user.attribute
5c445927-5197-4aff-a5c1-e2df3038cf4a	true	id.token.claim
5c445927-5197-4aff-a5c1-e2df3038cf4a	true	access.token.claim
5c445927-5197-4aff-a5c1-e2df3038cf4a	gender	claim.name
5c445927-5197-4aff-a5c1-e2df3038cf4a	String	jsonType.label
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	true	userinfo.token.claim
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	birthdate	user.attribute
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	true	id.token.claim
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	true	access.token.claim
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	birthdate	claim.name
2c1aeb54-8dda-4790-a68f-cb57b0f7bbd6	String	jsonType.label
dd54beda-3f2c-47e7-b973-62379df8ae9f	true	userinfo.token.claim
dd54beda-3f2c-47e7-b973-62379df8ae9f	zoneinfo	user.attribute
dd54beda-3f2c-47e7-b973-62379df8ae9f	true	id.token.claim
dd54beda-3f2c-47e7-b973-62379df8ae9f	true	access.token.claim
dd54beda-3f2c-47e7-b973-62379df8ae9f	zoneinfo	claim.name
dd54beda-3f2c-47e7-b973-62379df8ae9f	String	jsonType.label
b57ef259-6dd5-497b-a33f-75ae9e203f2c	true	userinfo.token.claim
b57ef259-6dd5-497b-a33f-75ae9e203f2c	locale	user.attribute
b57ef259-6dd5-497b-a33f-75ae9e203f2c	true	id.token.claim
b57ef259-6dd5-497b-a33f-75ae9e203f2c	true	access.token.claim
b57ef259-6dd5-497b-a33f-75ae9e203f2c	locale	claim.name
b57ef259-6dd5-497b-a33f-75ae9e203f2c	String	jsonType.label
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	true	userinfo.token.claim
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	updatedAt	user.attribute
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	true	id.token.claim
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	true	access.token.claim
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	updated_at	claim.name
44c1dc2d-9ff3-43d3-bf6c-c4cd872afda2	String	jsonType.label
c42c9276-60a2-487e-950a-91b4fef85d16	true	userinfo.token.claim
c42c9276-60a2-487e-950a-91b4fef85d16	email	user.attribute
c42c9276-60a2-487e-950a-91b4fef85d16	true	id.token.claim
c42c9276-60a2-487e-950a-91b4fef85d16	true	access.token.claim
c42c9276-60a2-487e-950a-91b4fef85d16	email	claim.name
c42c9276-60a2-487e-950a-91b4fef85d16	String	jsonType.label
86de1943-d49c-43d8-a4d6-192e0cca249e	true	userinfo.token.claim
86de1943-d49c-43d8-a4d6-192e0cca249e	emailVerified	user.attribute
86de1943-d49c-43d8-a4d6-192e0cca249e	true	id.token.claim
86de1943-d49c-43d8-a4d6-192e0cca249e	true	access.token.claim
86de1943-d49c-43d8-a4d6-192e0cca249e	email_verified	claim.name
86de1943-d49c-43d8-a4d6-192e0cca249e	boolean	jsonType.label
8e0ac251-7805-4c60-98e8-b40e0204f01e	formatted	user.attribute.formatted
8e0ac251-7805-4c60-98e8-b40e0204f01e	country	user.attribute.country
8e0ac251-7805-4c60-98e8-b40e0204f01e	postal_code	user.attribute.postal_code
8e0ac251-7805-4c60-98e8-b40e0204f01e	true	userinfo.token.claim
8e0ac251-7805-4c60-98e8-b40e0204f01e	street	user.attribute.street
8e0ac251-7805-4c60-98e8-b40e0204f01e	true	id.token.claim
8e0ac251-7805-4c60-98e8-b40e0204f01e	region	user.attribute.region
8e0ac251-7805-4c60-98e8-b40e0204f01e	true	access.token.claim
8e0ac251-7805-4c60-98e8-b40e0204f01e	locality	user.attribute.locality
f1fa68f8-f7fd-4271-9b14-1824af168bc8	true	userinfo.token.claim
f1fa68f8-f7fd-4271-9b14-1824af168bc8	phoneNumber	user.attribute
f1fa68f8-f7fd-4271-9b14-1824af168bc8	true	id.token.claim
f1fa68f8-f7fd-4271-9b14-1824af168bc8	true	access.token.claim
f1fa68f8-f7fd-4271-9b14-1824af168bc8	phone_number	claim.name
f1fa68f8-f7fd-4271-9b14-1824af168bc8	String	jsonType.label
59bb934e-a685-4740-9b14-819045555a83	true	userinfo.token.claim
59bb934e-a685-4740-9b14-819045555a83	phoneNumberVerified	user.attribute
59bb934e-a685-4740-9b14-819045555a83	true	id.token.claim
59bb934e-a685-4740-9b14-819045555a83	true	access.token.claim
59bb934e-a685-4740-9b14-819045555a83	phone_number_verified	claim.name
59bb934e-a685-4740-9b14-819045555a83	boolean	jsonType.label
d87b8c8a-55b4-46de-b508-75a4c9e6b271	true	multivalued
d87b8c8a-55b4-46de-b508-75a4c9e6b271	foo	user.attribute
d87b8c8a-55b4-46de-b508-75a4c9e6b271	true	access.token.claim
d87b8c8a-55b4-46de-b508-75a4c9e6b271	realm_access.roles	claim.name
d87b8c8a-55b4-46de-b508-75a4c9e6b271	String	jsonType.label
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	true	multivalued
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	foo	user.attribute
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	true	access.token.claim
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	resource_access.${client_id}.roles	claim.name
a7c43ab7-ba0d-4976-ac55-1dd9dae2fcb5	String	jsonType.label
6416d1ed-1157-4b97-84dc-2183c2983676	true	userinfo.token.claim
6416d1ed-1157-4b97-84dc-2183c2983676	username	user.attribute
6416d1ed-1157-4b97-84dc-2183c2983676	true	id.token.claim
6416d1ed-1157-4b97-84dc-2183c2983676	true	access.token.claim
6416d1ed-1157-4b97-84dc-2183c2983676	upn	claim.name
6416d1ed-1157-4b97-84dc-2183c2983676	String	jsonType.label
cc556f0b-a0b2-450a-b80d-3c308b135c37	true	multivalued
cc556f0b-a0b2-450a-b80d-3c308b135c37	foo	user.attribute
cc556f0b-a0b2-450a-b80d-3c308b135c37	true	id.token.claim
cc556f0b-a0b2-450a-b80d-3c308b135c37	true	access.token.claim
cc556f0b-a0b2-450a-b80d-3c308b135c37	groups	claim.name
cc556f0b-a0b2-450a-b80d-3c308b135c37	String	jsonType.label
ed36c7b2-457a-45b1-bf61-3c6592fe9146	true	userinfo.token.claim
ed36c7b2-457a-45b1-bf61-3c6592fe9146	locale	user.attribute
ed36c7b2-457a-45b1-bf61-3c6592fe9146	true	id.token.claim
ed36c7b2-457a-45b1-bf61-3c6592fe9146	true	access.token.claim
ed36c7b2-457a-45b1-bf61-3c6592fe9146	locale	claim.name
ed36c7b2-457a-45b1-bf61-3c6592fe9146	String	jsonType.label
ee82dd26-3389-4a90-b742-f7c8728fc2a9	clientId	user.session.note
ee82dd26-3389-4a90-b742-f7c8728fc2a9	true	id.token.claim
ee82dd26-3389-4a90-b742-f7c8728fc2a9	true	access.token.claim
ee82dd26-3389-4a90-b742-f7c8728fc2a9	clientId	claim.name
ee82dd26-3389-4a90-b742-f7c8728fc2a9	String	jsonType.label
af95a884-7ae9-4d83-925b-2d91fee52666	clientHost	user.session.note
af95a884-7ae9-4d83-925b-2d91fee52666	true	id.token.claim
af95a884-7ae9-4d83-925b-2d91fee52666	true	access.token.claim
af95a884-7ae9-4d83-925b-2d91fee52666	clientHost	claim.name
af95a884-7ae9-4d83-925b-2d91fee52666	String	jsonType.label
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	clientAddress	user.session.note
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	true	id.token.claim
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	true	access.token.claim
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	clientAddress	claim.name
e4b4e0f9-5093-4cf0-95ab-ff08b4760aad	String	jsonType.label
a6e609df-f590-46bb-9cb3-2e340891c60d	false	full.path
a6e609df-f590-46bb-9cb3-2e340891c60d	true	userinfo.token.claim
a6e609df-f590-46bb-9cb3-2e340891c60d	true	access.token.claim
a6e609df-f590-46bb-9cb3-2e340891c60d	true	id.token.claim
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	true	userinfo.token.claim
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	role_id	user.attribute
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	false	id.token.claim
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	false	access.token.claim
9a0c60bc-42f5-4ab6-ade4-76ccd77d831c	attribute	claim.name
a6e609df-f590-46bb-9cb3-2e340891c60d	group	claim.name
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	true	userinfo.token.claim
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	username	user.attribute
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	username	claim.name
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	true	id.token.claim
7f2afa35-0c8e-45b6-b9b1-62ac9074e7e3	true	access.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	adfbe5de-0bf8-45c4-ad67-64e454ff97e7	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	f62e94ce-5b9b-47d1-a00a-1b92d2ca3729	a6dd9b94-82ea-4b71-8ac0-20ba1288793b	104c9c70-583d-4458-b085-58458fc09e3a	7c28d169-3d90-4004-9679-048e418f2a99	3279791b-5a02-45f7-a345-faacd6671dcf	2592000	f	900	t	f	cf39e029-e58b-4f6e-92c7-cd6ed154781a	0	f	0	0	b29eb198-4a7d-4930-84a8-20097bdc64a6
worldcereal	60	300	300	\N	\N	\N	t	f	0	\N	worldcereal	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c2752f7b-34b4-4043-9945-0feb050e621f	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	c1243309-f26c-4228-95c0-2c1907127b4d	9d155ca7-a838-48a1-aeef-7fe4daf37dcc	6f2c260a-72ac-4f12-8203-4b8c832faa48	4f2c2750-8c21-4e7c-930d-6f63409398ed	4f8d001f-9152-40b1-ba0c-381192194344	2592000	f	900	t	f	118079b9-6bb7-4914-afa7-b9c6016a1830	0	f	0	0	439b847c-bca8-40fd-a6f0-eb20958acd50
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	worldcereal	
_browser_header.xContentTypeOptions	worldcereal	nosniff
_browser_header.xRobotsTag	worldcereal	none
_browser_header.xFrameOptions	worldcereal	SAMEORIGIN
_browser_header.contentSecurityPolicy	worldcereal	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	worldcereal	1; mode=block
_browser_header.strictTransportSecurity	worldcereal	max-age=31536000; includeSubDomains
bruteForceProtected	worldcereal	false
permanentLockout	worldcereal	false
maxFailureWaitSeconds	worldcereal	900
minimumQuickLoginWaitSeconds	worldcereal	60
waitIncrementSeconds	worldcereal	60
quickLoginCheckMilliSeconds	worldcereal	1000
maxDeltaTimeSeconds	worldcereal	43200
failureFactor	worldcereal	30
defaultSignatureAlgorithm	worldcereal	RS256
offlineSessionMaxLifespanEnabled	worldcereal	false
offlineSessionMaxLifespan	worldcereal	5184000
actionTokenGeneratedByAdminLifespan	worldcereal	43200
actionTokenGeneratedByUserLifespan	worldcereal	300
oauth2DeviceCodeLifespan	worldcereal	600
oauth2DevicePollingInterval	worldcereal	5
webAuthnPolicyRpEntityName	worldcereal	keycloak
webAuthnPolicySignatureAlgorithms	worldcereal	ES256
webAuthnPolicyRpId	worldcereal	
webAuthnPolicyAttestationConveyancePreference	worldcereal	not specified
webAuthnPolicyAuthenticatorAttachment	worldcereal	not specified
webAuthnPolicyRequireResidentKey	worldcereal	not specified
webAuthnPolicyUserVerificationRequirement	worldcereal	not specified
webAuthnPolicyCreateTimeout	worldcereal	0
webAuthnPolicyAvoidSameAuthenticatorRegister	worldcereal	false
webAuthnPolicyRpEntityNamePasswordless	worldcereal	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	worldcereal	ES256
webAuthnPolicyRpIdPasswordless	worldcereal	
webAuthnPolicyAttestationConveyancePreferencePasswordless	worldcereal	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	worldcereal	not specified
webAuthnPolicyRequireResidentKeyPasswordless	worldcereal	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	worldcereal	not specified
webAuthnPolicyCreateTimeoutPasswordless	worldcereal	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	worldcereal	false
cibaBackchannelTokenDeliveryMode	worldcereal	poll
cibaExpiresIn	worldcereal	120
cibaInterval	worldcereal	5
cibaAuthRequestedUserHint	worldcereal	login_hint
parRequestUriLifespan	worldcereal	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
worldcereal	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	worldcereal
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
72b3aa15-a699-4ff4-aa82-347837b1d306	/realms/master/account/*
362ed1e8-1d67-4d7d-9c4c-200636c32d33	/realms/master/account/*
7468cf99-e160-4c11-9770-12735d71e383	/admin/master/console/*
ad27c24a-448f-4f43-9a00-2437cd7053bd	/realms/worldcereal/account/*
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	/realms/worldcereal/account/*
285a7567-b365-4999-81ec-470646e1554e	/admin/worldcereal/console/*
fc85da61-1851-4ea0-9ee4-38d6bd0c71de	http://grafana.worldcereal.csgroup.space/*
cd17a140-2a42-4ae5-b3e2-57a730c6e5c1	rdm
5981bec6-31e5-44aa-aa76-f9815198f954	processing
f07d4e4b-371b-47db-867c-21a1853a25da	wctiler
38e0a874-f6b5-4f52-8b5b-75ec35d1d3ba	dissemination
935a293a-122f-43e2-b4a9-c57ff38e326a	http://prometheus.worldcereal.csgroup.space/*
ef1a9afd-41f2-4eaf-9813-48873052101e	http://graylog.worldcereal.csgroup.space/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
fa6892ad-5476-4a30-9c43-e2ed763b7c0c	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
3a1a90b8-6e87-403b-996a-8d833f3d064e	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
926c77c3-aaee-4ca4-ad0c-3fff77f43f30	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
5c9093a5-bfd4-4a1b-a019-72b52b872255	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
f948aabf-16a9-48ca-b999-62b0cb3e940c	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
aa805c19-f0e6-4803-9969-ae8e8b1abce6	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
1263403c-1dc3-4c7a-b3ff-dbdea62baa67	delete_account	Delete Account	master	f	f	delete_account	60
a671d4ad-6cd7-4896-9326-20deeb30077a	VERIFY_EMAIL	Verify Email	worldcereal	t	f	VERIFY_EMAIL	50
9af36ef1-af02-4a77-aee5-2e1f8c1522f8	UPDATE_PROFILE	Update Profile	worldcereal	t	f	UPDATE_PROFILE	40
93c7e4ba-1e1a-464c-aff8-0020fbb11103	CONFIGURE_TOTP	Configure OTP	worldcereal	t	f	CONFIGURE_TOTP	10
78a2da74-23a4-4adf-96b1-2c70c1902785	UPDATE_PASSWORD	Update Password	worldcereal	t	f	UPDATE_PASSWORD	30
d3dda90b-54b2-426e-a067-4d9a7a8888a7	terms_and_conditions	Terms and Conditions	worldcereal	f	f	terms_and_conditions	20
3e1fbd5f-351c-46bf-92f0-09613064f840	update_user_locale	Update User Locale	worldcereal	t	f	update_user_locale	1000
556ef451-9b63-4ab4-9713-7cbb85784e22	delete_account	Delete Account	worldcereal	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
e730aecf-3cc5-4020-bac3-1e8a1ebf7f25	7493e289-edbd-4920-ab00-3b58d70bf1d8	Test	tata
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
362ed1e8-1d67-4d7d-9c4c-200636c32d33	b51a10bc-c877-46d2-a1e2-7453c13eea8b
ad501cc8-304d-4bdd-9e8a-b6bf8d459d6b	a307202a-b006-4cca-8fb8-5d053bc7659e
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
role_id	4731a283-0697-467c-bafe-383d4a867e70	3e5ca7c0-0311-425c-aaca-2d88ad027b80	280a68e9-4ad0-4e3b-a3d5-15b3912a16d3
role_id	8c676118-a49e-4817-8b3f-edc742fdf42c	5e078943-be6c-4186-943b-e92c5643e05e	cffe0f0c-2da7-41ec-b29c-7aa461051cc6
role_id	123456789-987654321	76799a3e-131f-420d-b6b7-c130bad9d87e	fcce3028-0119-4f29-b3af-00fb7945daee
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
50c43acc-93e4-46ac-a7ab-048276d66a48	\N	c64716ff-6c9a-4bd4-8bcc-56c6398fa1df	f	t	\N	\N	\N	master	admin	1631008190917	\N	0
4b2fc7b8-a676-405e-92d3-4ff008e87b38	\N	6f4a75d2-2670-4f6b-9ea5-1d38d6c4814c	f	t	\N	\N	\N	worldcereal	ok	1631008596077	\N	0
576fff8a-8dcd-439b-af2f-e379a80be568	\N	59907605-fa78-4f31-9e44-80bf88f5ee1d	f	t	\N	\N	\N	worldcereal	nok	1631008623966	\N	0
3e5ca7c0-0311-425c-aaca-2d88ad027b80	\N	b300c710-c6bf-4c73-b9eb-9059009300f7	f	t	\N	\N	\N	worldcereal	all	1631023880292	\N	0
5e078943-be6c-4186-943b-e92c5643e05e	santosh@santosh.com	santosh@santosh.com	t	t	\N	Santosh	\N	worldcereal	santosh	1631779594854	\N	0
c33e1d5b-d309-4932-b393-67b3044a4aec	\N	d483368c-32e4-498a-91de-2f31432cb52b	f	t	\N	\N	\N	worldcereal	toto	1631783396163	\N	0
76799a3e-131f-420d-b6b7-c130bad9d87e	\N	80208126-cbd1-43fe-9a5c-ead239f89c0e	t	t	\N	\N	\N	worldcereal	nico	1631784251467	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
e5b2afdb-ee74-44e0-8ce2-9d13e673a361	3e5ca7c0-0311-425c-aaca-2d88ad027b80
e5b2afdb-ee74-44e0-8ce2-9d13e673a361	5e078943-be6c-4186-943b-e92c5643e05e
ed99f498-dd9e-4506-b60a-015b22c97817	4b2fc7b8-a676-405e-92d3-4ff008e87b38
ed99f498-dd9e-4506-b60a-015b22c97817	76799a3e-131f-420d-b6b7-c130bad9d87e
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
b29eb198-4a7d-4930-84a8-20097bdc64a6	50c43acc-93e4-46ac-a7ab-048276d66a48
ea29a635-4e34-458e-9459-b16a5f79ffc0	50c43acc-93e4-46ac-a7ab-048276d66a48
439b847c-bca8-40fd-a6f0-eb20958acd50	4b2fc7b8-a676-405e-92d3-4ff008e87b38
439b847c-bca8-40fd-a6f0-eb20958acd50	576fff8a-8dcd-439b-af2f-e379a80be568
7493e289-edbd-4920-ab00-3b58d70bf1d8	4b2fc7b8-a676-405e-92d3-4ff008e87b38
d9f0265d-7b95-4455-832f-b43da488a280	576fff8a-8dcd-439b-af2f-e379a80be568
439b847c-bca8-40fd-a6f0-eb20958acd50	5e078943-be6c-4186-943b-e92c5643e05e
439b847c-bca8-40fd-a6f0-eb20958acd50	c33e1d5b-d309-4932-b393-67b3044a4aec
7493e289-edbd-4920-ab00-3b58d70bf1d8	c33e1d5b-d309-4932-b393-67b3044a4aec
439b847c-bca8-40fd-a6f0-eb20958acd50	76799a3e-131f-420d-b6b7-c130bad9d87e
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: bn_keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
7468cf99-e160-4c11-9770-12735d71e383	+
285a7567-b365-4999-81ec-470646e1554e	+
935a293a-122f-43e2-b4a9-c57ff38e326a	
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: bn_keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: bn_keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: bn_keycloak
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO bn_keycloak;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

