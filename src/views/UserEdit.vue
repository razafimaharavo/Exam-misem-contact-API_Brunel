<template>
  <div class="user-edit">
    <h1>Modification d'utilisateur</h1>
    <form @submit.prevent="updateUser">
      <input v-model="user.name" placeholder="Name" />
      <input v-model="user.first_name" placeholder="First Name" />
      <input v-model="user.numTel" placeholder="Phone Number" />
      <input type="file" @change="handleFileUpload" />
      <button type="submit">Update</button>
    </form>
    <router-link :to="{ name: 'userDetail', params: { id: $route.params.id } }" class="link">Retour aux détails de l'utilisateur</router-link>
    <div v-if="errors.length">
      <ul>
        <li v-for="error in errors" :key="error">{{ error }}</li>
      </ul>
    </div>
  </div>
</template>

<script>
import api from '../services/api';

export default {
  data() {
    return {
      user: {
        name: '',
        first_name: '',
        numTel: '',
        image: null
      },
      errors: []
    };
  },
  created() {
    this.fetchUser();
  },
  methods: {
    fetchUser() {
      api.getUser(this.$route.params.id)
        .then(response => {
          this.user = response.data;
        })
        .catch(error => {
          console.error('Erreur lors de la récupération de l\'utilisateur :', error);
        });
    },
    handleFileUpload(event) {
      this.user.image = event.target.files[0];
    },
    updateUser() {
      const formData = new FormData();
      formData.append('name', this.user.name);
      formData.append('first_name', this.user.first_name);
      formData.append('numTel', this.user.numTel);
      if (this.user.image) {
        formData.append('image', this.user.image);
      }

      api.updateUser(this.$route.params.id, formData)
        .then(() => {
          this.$router.push({ name: 'userDetail', params: { id: this.$route.params.id } });
        })
        .catch(error => {
          if (error.response && error.response.status === 422) {
            this.errors = Object.values(error.response.data.errors).flat();
          } else {
            console.error('Erreur lors de la mise à jour de l\'utilisateur :', error);
          }
        });
    }
  }
};
</script>











<style scoped>
.user-edit {
  max-width: 400px;
  margin: 0 auto;
  padding: 20px;
  background-color: rgba(0, 0, 0, 0.7);
  border-radius: 8px;
  text-align: center;
  color: white;
  border: 1px solid #ddd;
}

.user-edit input {
  width: calc(100% - 20px);
  margin: 10px;
  padding: 10px;
  background-color: rgba(255, 255, 255, 0.1);
  border: none;
  color: white;
  border-radius: 4px;
}

.user-edit button {
  padding: 10px 20px;
  background-color: rgba(33, 150, 243, 0.7);
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.user-edit button:hover {
  background-color: rgba(33, 150, 243, 1);
}

.link {
  display: inline-block;
  margin-top: 20px;
  padding: 10px 20px;
  background-color: rgba(33, 150, 243, 0.7);
  color: white;
  text-decoration: none;
  border-radius: 4px;
}

.link:hover {
  background-color: rgba(33, 150, 243, 1);
}

/* Ajout de styles pour les erreurs */
.user-edit div {
  margin-top: 10px;
  color: #ff4d4f;
}

.user-edit div ul {
  list-style: none;
  padding-left: 0;
}

.user-edit div ul li {
  margin-bottom: 5px;
}
</style>



<!-- <template>
    <div class="container user-edit">
      <h1 class="text-center">Modification d'utilisateur</h1>
      <form @submit.prevent="updateUser">
        <div class="form-group">
          <label for="name">Name:</label>
          <input v-model="name" type="text" class="form-control" id="name" placeholder="Enter name">
        </div>
        <div class="form-group">
          <label for="email">Email:</label>
          <input v-model="email" type="email" class="form-control" id="email" placeholder="Enter email">
        </div>
        <div class="form-group">
          <label for="password">Password:</label>
          <input v-model="password" type="password" class="form-control" id="password" placeholder="Enter password">
        </div>
        <button type="submit" class="btn btn-primary">Modifier</button>
      </form>
      <router-link :to="{ name: 'userDetail', params: { id: $route.params.id } }" class="btn btn-secondary mt-3">Retour</router-link>
      <div v-if="errors.length" class="mt-3">
        <ul class="list-unstyled">
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </div>
    </div>
  </template>
  
  <script>
  import api from '../services/api';
  
  export default {
    data() {
      return {
        name: '',
        email: '',
        password: '',
        errors: []
      };
    },
    created() {
      api.getUser(this.$route.params.id).then(response => {
        const user = response.data;
        this.name = user.Name;
        this.email = user.Email;
        this.password = user.Password;
      });
    },
    methods: {
      updateUser() {
        const userData = {
          Name: this.name,
          Email: this.email,
          Password: this.password
        };
        api.updateUser(this.$route.params.id, userData)
          .then(() => {
            this.$router.push({ name: 'userDetail', params: { id: this.$route.params.id } });
          })
          .catch(error => {
            if (error.response && error.response.status === 422) {
              this.errors = Object.values(error.response.data.errors).flat();
            } else {
              console.error('Erreur lors de la mise à jour de l\'utilisateur :', error);
            }
          });
      }
    }
  };
  </script> -->