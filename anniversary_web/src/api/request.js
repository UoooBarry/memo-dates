import axios from 'axios';

const serverUrl = process.env.VUE_APP_BASE_URL

const request = axios.create({
  baseURL: `${serverUrl}`,
  timeout: 5000
});

const onSuccess = (response) => {
  if (!String(response.headers['content-type']).includes('application/json')) {
    return response;
  }
  const { data } = response;
  return data;
};

const onError = (error) => {
  throw error;
}

request.interceptors.response.use(onSuccess, onError);

export default request;
