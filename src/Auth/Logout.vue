<template>
  <button class="btnLogout" @click="logout">Logout</button>
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

<style>
.btnLogout {
  padding: 6px 20px;
  text-decoration: none;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  color: white;
}

.btnLogout {
  background-color: #4a26ca;
}
</style>
