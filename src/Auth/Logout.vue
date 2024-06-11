<template>
  <button @click="logout">Logout</button>
</template>

<script>
import axios from 'axios';

export default {
  methods: {
    async logout() {
      try {
        const token = localStorage.getItem('token');
        const response = await axios.post('http://localhost:8000/api/logout', {}, {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        });
        console.log(response.data);
        // Supprimer le jeton après la déconnexion
        localStorage.removeItem('token');
        // Rediriger vers la page de connexion
        this.$router.push('/login');
      } catch (error) {
        console.error(error.response.data);
      }
    }
  }
}
</script>
