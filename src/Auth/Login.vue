   <!-- <template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-title>Login</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-content class="ion-padding">
        <ion-item>
          <ion-label position="floating">Email</ion-label>
          <ion-input type="email" v-model="email" required></ion-input>
        </ion-item>
        <ion-item>
          <ion-label position="floating">Password</ion-label>
          <ion-input type="password" v-model="password" required></ion-input>
        </ion-item>
        <div class="ion-margin-top">
          <ion-button expand="block" @click="login">Login</ion-button>
        </div>
        <div class="ion-margin-top">
          <RouterLink to="/register" class="link">Register</RouterLink>
        </div>
        <div v-if="loginError" class="error">
          {{ loginError }}
        </div>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonItem, IonLabel, IonInput, IonButton } from '@ionic/vue';
  import { RouterLink } from 'vue-router';
  import api from '@/services/api';
  
  export default {
    name: 'LoginPage',
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
        email: '',
        password: '',
        loginError: ''
      };
    },
    methods: {
      async login() {
        try {
          const response = await api.loginUser({
            email: this.email,
            password: this.password
          });
  
          // Stocker le jeton dans le stockage local
          localStorage.setItem('token', response.data.success.token);
  
          // Rediriger vers la page d'accueil après une connexion réussie
          this.$router.push({ name: 'HomeContact' });
        } catch (error) {
          console.error(error.response.data);
          this.loginError = 'Login failed. Please check your credentials and try again.';
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
   -->


   <template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-title>Login</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-content class="ion-padding">
        <ion-item>
          <ion-label position="floating">Email</ion-label>
          <ion-input type="email" v-model="email" required></ion-input>
        </ion-item>
        <ion-item>
          <ion-label position="floating">Password</ion-label>
          <ion-input type="password" v-model="password" required></ion-input>
        </ion-item>
        <div class="ion-margin-top">
          <ion-button expand="block" @click="login">Login</ion-button>
        </div>
        <div class="ion-margin-top">
          <RouterLink to="/register" class="link">Register</RouterLink>
        </div>
        <div v-if="loginError" class="error">
          {{ loginError }}
        </div>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonItem, IonLabel, IonInput, IonButton } from '@ionic/vue';
  import { RouterLink } from 'vue-router';
  import api from '@/services/api';
  
  export default {
    name: 'LoginPage',
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
        email: '',
        password: '',
        loginError: ''
      };
    },
    methods: {
      async login() {
        try {
          const response = await api.loginUser({
            email: this.email,
            password: this.password
          });
  
          console.log(response); // Journal pour inspecter la réponse
  
          if (response && response.data && response.data.success) {
            // Stocker le jeton dans le stockage local
            localStorage.setItem('token', response.data.success.token);
  
            // Rediriger vers la page d'accueil après une connexion réussie
            this.$router.push({ name: 'HomePage' });
          } else {
            this.loginError = 'Login failed. Please check your credentials and try again.';
          }
        } catch (error) {
          console.error(error); // Journal pour inspecter l'erreur
          this.loginError = 'Login failed. Please check your credentials and try again.';
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
  