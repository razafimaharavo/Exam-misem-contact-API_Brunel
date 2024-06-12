

import axios from 'axios';

const apiClient = axios.create({
     baseURL: 'http://127.0.0.1:8000',
    // baseURL: process.env.VUE_APP_API_URL, // Utiliser l'URL de base configurée dans .env
});

export default {
    getUsers() {
        return apiClient.get('/contacts');
    },
    getUser(id) {
        return apiClient.get(`/contacts/${id}`);
    },
    createUser(data) {
        return apiClient.post('/contacts', data, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
    },
    updateUser(id, data) {
        return apiClient.post(`/contacts/${id}`, data, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });
    },
    deleteUser(id) {
        return apiClient.delete(`/contacts/${id}`);
    }
};
