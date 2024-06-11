<template>
  <div class="loginClass">
    <h2>Login</h2>
    <form @submit.prevent="login">
      <div class="form_div">
        <input type="email" class="form_input" v-model="email" placeholder=" " required>
        <label class="form_label">Email:</label>
      </div>
      <div class="form_div">
        <input type="password" class="form_input" v-model="password" placeholder=" " required>
        <label class="form_label">Password:</label>
      </div>
      <button type="submit">Login</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'Login',
  data() {
    return {
      email: '',
      password: ''
    };
  },
  methods: {
    async login() {
      try {
        const response = await axios.post('http://localhost:8000/api/login', {
          email: this.email,
          password: this.password
        });
        
        // Stocker le jeton dans le stockage local
        localStorage.setItem('token', response.data.success.token);
        
        // Rediriger vers la page d'accueil après une connexion réussie
        this.$router.push({ name: 'Home' });
      } catch (error) {
        console.error(error.response.data);
        alert('Login failed. Please check your credentials and try again.');
      }
    }
  }
};
</script>

<style scoped>
  .loginClass {
    max-width: 400px;
    margin: 0 auto;
    padding: 20px;
    background-color: rgba(0, 0, 0, 0.7);
    border-radius: 8px;
    text-align: center;
    color: white;
    border: 1px solid #8d8b8b;
    position: relative;
    top: 10pc;
  }

  h2{
    color: #23a2f6;
  }
  
  .loginClass input {
    width: calc(100% - 20px);
    margin: 10px;
    padding: 10px;
    background-color: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    border-radius: 4px;
  }
  
  .loginClass button {
    padding: 10px 20px;
    background-color: rgba(33, 150, 243, 0.7);
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  
  .loginClass button:hover {
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
    background-color: rgba(33, 150, 243, 0.7);
    color: white;
    text-decoration: none;
    border-radius: 4px;
  }
  
  .link:hover {
    background-color: rgba(33, 150, 243, 1);
  }




  .form_div {
    width: 100%;
    margin-top: 10px;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 1.5rem;
}

.form_div input {
    flex: 1;
}

.form_input {
    font-size: 1rem;
    position: relative;
    width: calc(100% - 130px);
    height: 100%;
    border: none;
    box-shadow: 0 0 20px 9px #1b1f2955;
    border-radius: .5rem;
    outline: none;
    padding: 1rem;
    background: transparent;
    transition: 0.3s;
    z-index: 1;
    color: #fff;
}

.form_label {
    position: absolute;
    left: 1rem;
    top: 1rem;
    padding: 0 0.25rem;
    background-color: transparent;
    color: #727272;
    font-size: 1rem;
    transition: 0.3s;
}

.form_input:focus + .form_label {
    top: -0.5rem;
    left: 0.8rem;
    color: #fff;
    font-size: 0.75rem;
    font-weight: 500;
    z-index: 10;
    background: linear-gradient(to bottom right, #ff3399 0%, #6600cc 100%);
    border-radius: 10px;
    padding: 0 5px;
}

.form_input:not(:placeholder-shown).form_input:not(:focus) + .form_label {
    top: -0.5rem;
    left: 0.8rem;
    font-size: 0.75rem;
    font-weight: 500;
    background: linear-gradient(to bottom right, #ff3399 0%, #6600cc 100%);
    border-radius: 10px;
    color: #fff;
    z-index: 10;
}

.form_input:focus {
    border: 1.5px solid #6600cc;
}
  </style>