   <template>
    <div class="user-create">
      <h1>Creation de contact</h1>
      <form @submit.prevent="createUser" enctype="multipart/form-data">
        <input v-model="name" placeholder="Name" required />
        <input v-model="firstName" placeholder="First Name" required />
        <input v-model="numTel" placeholder="Telephone Number" required />
        <input type="file" @change="onFileChange" required />
        <button type="submit" class="btnCreate">Create</button>
      </form>
      <div v-if="errors.length" class="errors">
        <ul>
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
      </div>
      <router-link to="/home" class="link">Retour</router-link>
    </div>
  </template>
  
  <script>
  import api from '../services/api';
  
  export default {
    data() {
      return {
        name: '',
        firstName: '',
        numTel: '',
        image: null,
        errors: []
      };
    },
    methods: {
      onFileChange(e) {
        this.image = e.target.files[0];
      },
      async createUser() {
        const formData = new FormData();
        formData.append('name', this.name);
        formData.append('first_name', this.firstName);
        formData.append('numTel', this.numTel);
        formData.append('image', this.image);
  
        try {
          await api.createUser(formData);
          this.$router.push('/users');
        } catch (error) {
          if (error.response && error.response.status === 422) {
            this.errors = Object.values(error.response.data.errors).flat();
          } else {
            console.error('Erreur lors de la création de l\'utilisateur :', error);
          }
        }
      }
    }
  };
  </script>
  
  <style scoped>
  .user-create {
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    background-color: rgba(0, 0, 0, 0.7);
    border-radius: 8px;
    text-align: center;
    color: white;
    border: 1px solid #ddd;
  }
  
  .user-create input {
    width: calc(100% - 20px);
    margin: 10px;
    padding: 10px;
    background-color: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    border-radius: 4px;
  }
  
  .user-create button {
    padding: 10px 20px;
    background-color: rgba(33, 150, 243, 0.7);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .user-create button:hover {
    background-color: rgba(33, 150, 243, 1);
  }
  
  .errors {
    margin-top: 20px;
    color: red;
  }
  
  .link {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 20px;
    background-color: rgba(3, 179, 12, 0.897);
    color: white;
    text-decoration: none;
    border-radius: 4px;
  }
  
  .link:hover {
    background-color: rgba(33, 150, 243, 1);
  }
  </style>
  