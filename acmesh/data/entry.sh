#!/usr/bin/env bashio
CONFIG_PATH=/data/options.json

[ ! -d "${LE_CONFIG_HOME}" ] && mkdir -p "${LE_CONFIG_HOME}"

if [ ! -f "${LE_CONFIG_HOME}/account.conf" ]; then
    bashio::log.info "Copying the default account.conf file"
    cp /default_account.conf "${LE_CONFIG_HOME}/account.conf"
fi

ACCOUNT_EMAIL=$(bashio::config 'accountemail')
DOMAIN=$(bashio::config 'domain')
DNS_PROTO=$(bashio::config 'dns')
DNS_ENV_OPTIONS=$(jq -r '.dnsEnvVariables |map("export \(.name)=\(.value|tojson)")|.[]' $CONFIG_PATH)
KEY_LENGTH=$(bashio::config 'keylength')
FULLCHAIN_FILE=$(bashio::config 'fullchainfile')
KEY_FILE=$(bashio::config 'keyfile')

source <(echo ${DNS_ENV_OPTIONS});

bashio::log.info "Registering account"
acme.sh --register-account -m ${ACCOUNT_EMAIL}

bashio::log.info "Issuing certificate for domain: ${DOMAIN}"

function issue {
    # Issue the certificate exit corretly if is not time to renew
    local RENEW_SKIP=2
    acme.sh --issue --domain ${DOMAIN} \
        --keylength ${KEY_LENGTH} \
        --dns ${DNS_PROTO} \
        || { ret=$?; [ $ret -eq ${RENEW_SKIP} ] && return 0 || return $ret ;}
}

issue

bashio::log.info "Installing certificate to: /ssl/${DOMAIN}"
keyArg=$( [[ ${KEY_LENGTH} == ec-* ]] && echo '--ecc' || echo '' )
[ ! -d "/ssl/${DOMAIN}/" ] && mkdir -p "/ssl/${DOMAIN}/"
acme.sh --install-cert --domain ${DOMAIN} \
    ${keyArg} \
    --key-file       "/ssl/${DOMAIN}/${KEY_FILE}" \
    --fullchain-file "/ssl/${DOMAIN}/${FULLCHAIN_FILE}"


bashio::log.info "All ok, running cron to automatically renew certificate"
trap "echo stop && killall crond && exit 0" SIGTERM SIGINT
crond && while true; do sleep 1; done;
