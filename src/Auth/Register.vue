<template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-title>Register</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-content class="ion-padding">
        <ion-item>
          <ion-label position="floating">Name</ion-label>
          <br>
          <ion-input v-model="name" required></ion-input>
        </ion-item>
        <ion-item>
          <ion-label position="floating">Email</ion-label>
          <br>
          <ion-input type="email" v-model="email" required></ion-input>
        </ion-item>
        <ion-item>
          <ion-label position="floating">Password</ion-label>
          <br>
          <ion-input type="password" v-model="password" required></ion-input>
        </ion-item>
        <ion-item>
          <ion-label position="floating">Confirm Password</ion-label>
          <br>
          <ion-input type="password" v-model="password_confirmation" required></ion-input>
        </ion-item>
        <div class="ion-margin-top">
          <ion-button expand="block" @click="register">Register</ion-button>
        </div>
        <div class="ion-margin-top">
          <RouterLink to="/login" class="link">Login</RouterLink>
        </div>
        <div v-if="errors.name" class="error">{{ errors.name[0] }}</div>
        <div v-if="errors.email" class="error">{{ errors.email[0] }}</div>
        <div v-if="errors.password" class="error">{{ errors.password[0] }}</div>
        <div v-if="serverError" class="error">{{ serverError }}</div>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonItem, IonLabel, IonInput, IonButton } from '@ionic/vue';
  import { RouterLink } from 'vue-router';
  import api from '@/services/api';
  
  export default {
    name: 'RegisterPage',
    components: {
      IonPage,
      IonHeader,
      IonToolbar,
      IonTitle,
      IonContent,
      IonItem,
      IonLabel,
      IonInput,
      IonButton,
      RouterLink
    },
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
          const response = await api.createUserRegister({
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
  
  <style scoped>
  /* Ajoutez vos styles ici */
  .error {
    color: red;
    margin-top: 10px;
  }
  .link {
    text-decoration: none;
    color: #3880ff;
  }
  </style>
  