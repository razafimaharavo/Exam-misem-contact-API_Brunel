// import axios from 'axios';

// const apiClient = axios.create({
//     baseURL: 'http://127.0.0.1:8000',
//     headers: {
//         'Content-Type': 'application/json'
//     }
// });

// export default {
//     getUsers() {
//         return apiClient.get('/contacts');
//     },
//     getUser(id) {
//         return apiClient.get(`/contacts/${id}`);
//     },
//     createUser(data) {
//         return apiClient.post('/contacts', data);
//     },
//     updateUser(id, data) {
//         return apiClient.put(`/contacts/${id}`, data);
//     },
//     deleteUser(id) {
//         return apiClient.delete(`/contacts/${id}`);
//     }
// };

import axios from 'axios';

const apiClient = axios.create({
    baseURL: 'http://127.0.0.1:8000',
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
