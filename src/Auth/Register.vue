  <template>
    <div class="registerClass">
      <h2>Register</h2>
      <form @submit.prevent="register">
        <div>
          <label>Name:</label>
          <input type="text" v-model="name" required>
          
        </div>
        <div>
          <label>Email:</label>
          <input type="email" v-model="email" required>
        </div>
        <div>
          <label>Password:</label>
          <input type="password" v-model="password" required>
        </div>
        <div>
          <label>Confirm Password:</label>
          <input type="password" v-model="password_confirmation" required>
        </div>
        <router-link to="/login" class="link">Login</router-link>
        <button type="submit">Register</button>
      </form>
      <div>
        <div v-if="errors.name" class="error">{{ errors.name[0] }}</div>
        <div v-if="errors.email" class="error">{{ errors.email[0] }}</div>
        <div v-if="errors.password" class="error">{{ errors.password[0] }}</div>
      </div>
      <div v-if="serverError" class="error">
        {{ serverError }}
      </div>
    </div>
  </template>
  
  <script>
  import axios from 'axios'; // Assurez-vous d'importer le fichier axios configuré
  
  export default {
    data() {
      return {
        name: '',
        email: '',
        password: '',
        password_confirmation: '',
        errors: {},
        serverError: ''
      };
    },
    methods: {
      async register() {
        try {
          const response = await axios.post('http://localhost:8000/api/register', {
            name: this.name,
            email: this.email,
            password: this.password,
            password_confirmation: this.password_confirmation
          });
          console.log(response.data);
          // Rediriger vers la page de connexion ou d'accueil après l'inscription réussie
          this.$router.push('/login');
        } catch (error) {
          if (error.response && error.response.status === 422) {
            // Gestion des erreurs de validation
            this.errors = error.response.data.errors;
          } else {
            // Gestion des autres erreurs du serveur
            this.serverError = 'Something went wrong. Please try again later.';
          }
        }
      }
    }
  };
  </script>
  
  <style>
  .registerClass {
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    background-color: rgba(0, 0, 0, 0.7);
    border-radius: 8px;
    text-align: center;
    color: white;
    border: 1px solid #666666;
    position: relative;
    top: 6pc;
  }
  
  .registerClass input {
    width: calc(100% - 20px);
    margin: 10px;
    padding: 10px;
    background-color: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    border-radius: 4px;
  }
  
  .registerClass button {
    padding: 10px 20px;
    background-color: rgba(33, 150, 243, 0.7);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .registerClass button:hover {
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

  .error {
    color: red;
    font-size: 0.9em;
  }
  </style>
  