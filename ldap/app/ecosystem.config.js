module.exports = {
  apps : [
    {
      name      : 'LDAP server',
      script    : 'serverLDAP.js'
    }
  ],
  deploy : {
    production : {
      user : 'node',
      path : '/var/www/production',
      'post-deploy' : 'npm install && pm2 reload ecosystem.config.js --env production'
    }
  }
};
