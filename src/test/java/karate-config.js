function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiURL: 'https://conduit-api.bondaracademy.com/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'testing123987@test.com';
    config.userPassword = 'Hola123123';
  } else if (env == 'qa') {
    config.userEmail = 'testing123987-1@test.com';
    config.userPassword = 'Hola123123-1';
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken;
  karate.configure('headers', { Authorization: 'Token ' + accessToken });
  return config;
}