<template>
  <div class="home">
    <h1>Accueil</h1>
    <router-link to="/users" class="link">Voir la liste des utilisateurs</router-link>
    <hr>
    <router-link to="/users/create" class="link">Ajouter un utilisateur</router-link>

    <footer>
      <logout></logout>
    </footer>
  </div>
</template>

<script>
import Logout from '@/Auth/Logout.vue'; // Assurez-vous de spécifier le bon chemin vers votre composant Logout

export default {
  name: 'Home',
  components: {
    Logout
  }
}
</script>

<style scoped>
.home {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  text-align: center;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  background-color: transparent
}

.link {
  display: block;
  margin: 10px 0;
  padding: 10px;
  background-color: rgba(33, 150, 243, 0.7);
  color: white;
  text-decoration: none;
  border-radius: 4px;
}

.link:hover {
  background-color: rgba(33, 150, 243, 1);
}
</style>
