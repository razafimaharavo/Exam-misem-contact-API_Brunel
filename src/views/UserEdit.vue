<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button defaultHref="/users" text="Retour"></ion-back-button>
        </ion-buttons>
        <ion-title>Modification du contact</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <div class="user-edit">
        <h1>Modification du contact</h1>
        <form @submit.prevent="updateUser" enctype="multipart/form-data" class="ion-padding">
          <ion-item>
            <ion-label position="floating">Name:</ion-label>
            <br>
            <ion-input v-model="user.name"></ion-input>
          </ion-item>
          <ion-item>
            <ion-label position="floating">First Name:</ion-label>
            <br>
            <ion-input v-model="user.first_name"></ion-input>
          </ion-item>
          <ion-item>
            <ion-label position="floating">Phone Number:</ion-label>
            <br>
            <ion-input v-model="user.numTel"></ion-input>
          </ion-item>
          <br>
          <ion-item>
            <ion-label>Image:</ion-label>
            <input type="file" @change="handleFileUpload" />
          </ion-item>
          <br>
          <ion-button type="submit">Update</ion-button>
        </form>
        <div v-if="errors.length" class="ion-padding">
          <ion-list>
            <ion-item v-for="error in errors" :key="error">{{ error }}</ion-item>
          </ion-list>
        </div>
      </div>
    </ion-content>
  </ion-page>
</template>

<script>
import {
  IonPage, IonContent, IonHeader, IonToolbar, IonButtons, IonBackButton, IonTitle, IonItem, IonLabel,  IonInput, IonButton, IonList
} from '@ionic/vue';
import api from '@/services/api';

export default {
  components: {
    IonPage,
    IonContent,
    IonHeader,
    IonToolbar,
    IonButtons,
    IonBackButton,
    IonTitle,
    IonItem,
    IonLabel,
    IonInput,
    IonButton,
    IonList
  },
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
/* Styles spécifiques au composant UserEdit.vue */
</style>
