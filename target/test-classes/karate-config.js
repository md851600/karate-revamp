function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property:', env);

  if (!env) {
    env = 'dev'; // default to 'dev' if not set
  }

  // Define environment configurations directly
  var environments = {
    dev: {
      baseUrl: 'https://dev.insurance-api.tekschool-students.com',
      dbUrl: 'jdbc:mysql://localhost:3306/devdb',
      timeouts: {
        connection: 5000,
        read: 10000,
      },
    },
    qa: {
      baseUrl: 'https://qa.insurance-api.tekschool-students.com',
      dbUrl: 'jdbc:mysql://localhost:3306/qadb',
      timeouts: {
        connection: 5000,
        read: 10000,
      },
    },
    prod: {
      baseUrl: 'https://api.prod.com',
      dbUrl: 'jdbc:mysql://localhost:3306/proddb',
      timeouts: {
        connection: 5000,
        read: 10000,
      },
    },
  };

  // Select the environment-specific configuration
  var envConfig = environments[env];

  var config = {
    baseUrl: envConfig.baseUrl,
    dbUrl: envConfig.dbUrl,
    connectionTimeout: envConfig.timeouts.connection,
    readTimeout: envConfig.timeouts.read,
    authToken: '',
  };

  // Fetch auth token if required
//  var authToken = karate.callSingle('classpath:tokens/getToken.feature', config);
//  config.authToken = authToken;

  return config;
}
