   <template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-title>Création de contact</ion-title>
        </ion-toolbar>
      </ion-header>
  
      <ion-content class="ion-padding">
        <form @submit.prevent="createUser" enctype="multipart/form-data">
          <ion-item>
            <!-- <ion-label position="floating">Name</ion-label> -->
            <ion-input v-model="name" placeholder="Name" required></ion-input>
          </ion-item>
          <ion-item>
            <!-- <ion-label position="floating">First Name</ion-label> -->
            <ion-input v-model="firstName" placeholder="First Name" required></ion-input>
          </ion-item>
          <ion-item>
            <!-- <ion-label position="floating">Telephone Number</ion-label> -->
            <ion-input v-model="numTel" placeholder="Telephone Number" required></ion-input>
          </ion-item>
          <br>
          <input type="file" @change="onFileChange" required />
          <br><br>
          <ion-button type="submit" expand="block">Create</ion-button>
        </form>
  
        <div v-if="errors.length" class="errors">
          <ion-list>
            <ion-item v-for="error in errors" :key="error">{{ error }}</ion-item>
          </ion-list>
        </div>
  
        <ion-button :router-link="{ name: 'HomePage' }" expand="block">Retour</ion-button>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import {
    IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonItem, IonInput, IonButton, IonList
  } from '@ionic/vue';
  import api from '../services/api';
  
  export default {
    name: 'UserCreate',
    components: {
      IonPage,
      IonHeader,
      IonToolbar,
      IonTitle,
      IonContent,
      IonItem,
      IonInput,
      IonButton,
      IonList
    },
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
  /* Styles spécifiques au composant UserCreate.vue */
  </style>
  