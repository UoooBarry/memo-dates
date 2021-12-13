import request from './request';

const getEvents = () => {
  return request.get('/events');
}

const createEvent = (form) => {
  return request.post('/events', form, { headers: { 'Content-Type': 'multipart/form-data' } });
}

const updateEvent = (id, form) => {
  return request.put(`/events/${id}`, form, { headers: { 'Content-Type': 'multipart/form-data' } });
}

const getFullFile = (path) => {
  const serverUrl = process.env.VUE_APP_BASE_URL;
  return `${serverUrl}${path}`
}

const deleteEvent = (id) => {
  return request.delete(`/events/${id}`);
}

export { getEvents, createEvent, getFullFile, updateEvent, deleteEvent };
