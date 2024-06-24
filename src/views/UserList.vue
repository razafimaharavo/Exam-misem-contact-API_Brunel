<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button defaultHref="/home" text="Retour"></ion-back-button>
        </ion-buttons>
        <ion-title>Liste des contacts</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <div v-if="loading" class="loading-container">
        <ion-spinner class="loading-spinner"></ion-spinner>
      </div>
      <div v-else class="user-list">
        <UserCard v-for="user in users" :key="user.id" :user="user" />
      </div>
      <ion-fab vertical="bottom" horizontal="end" slot="fixed">
        <ion-fab-button @click="refreshUsers">
          <ion-icon name="refresh"></ion-icon>
        </ion-fab-button>
      </ion-fab>
      <div class="buttons">
        <ion-button :router-link="{ name: 'HomePage' }" expand="block">Retour</ion-button>
      </div>
    </ion-content>
  </ion-page>
</template>

<script>
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonButton, IonBackButton, IonSpinner, IonFab, IonFabButton, IonIcon } from '@ionic/vue';

import api from '../services/api';
import UserCard from '@/components/UserCard.vue';

export default {
  components: {
    IonPage,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButtons,
    IonButton,
    IonBackButton,
    IonSpinner,
    IonFab,
    IonFabButton,
    IonIcon,
    UserCard
  },
  data() {
    return {
      users: [],
      loading: true
    };
  },
  created() {
    this.fetchUsers();
  },
  methods: {
    fetchUsers() {
      this.loading = true;
      api.getUsers()
        .then(response => {
          this.users = response.data;
          this.loading = false;
        })
        .catch(error => {
          console.error('Erreur lors du chargement des utilisateurs :', error);
          this.loading = false;
        });
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        vm.fetchUsers();
      });
    },
    refreshUsers() {
      this.fetchUsers();
    }
  }
};
</script>

<style scoped>


.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

.loading-spinner {
  width: 50px;
  height: 50px;
}

.user-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
}

ion-fab {
  position: absolute;
  bottom: 20px;
  right: 20px;
}

.buttons {
  display: flex;
  flex-direction: column;
  gap: 10px;
  margin-top: 20px;
}

.back-link {
  display: inline-block;
  margin-top: 20px;
  padding: 10px 20px;
  background-color: #2196f3;
  color: white;
  text-decoration: none;
  border-radius: 4px;
  cursor: pointer;
}
</style>
