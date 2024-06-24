<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-buttons slot="start">
          <ion-back-button defaultHref="/users" text="Retour"></ion-back-button>
        </ion-buttons>
        <ion-title>Détails du contact</ion-title>
      </ion-toolbar>
    </ion-header>

    <ion-content class="ion-padding">
      <div class="user-detail">
        <h1 class="title">Détails du contact</h1>
        <div class="user-info ion-padding">
          <ion-img :src="imageUrl" alt="User Image" class="user-image"></ion-img>
          <div class="user-details">
            <p>Nom: <strong>{{ user.name }}</strong> </p>
            <p>Prénom: <strong>{{ user.first_name }}</strong></p>
            <p>Numéro téléphone: <strong>{{ user.numTel }}</strong></p>
          </div>
        </div>
        <div class="user-actions ion-padding">
          <ion-button :router-link="{ name: 'UserEdit', params: { id: user.id } }" class="edit-link">
            Edit
          </ion-button>
          <ion-button @click="confirmDelete" class="delete-button">Delete</ion-button>
          <ion-button @click="navigateToUserList" class="back-link">Retour</ion-button>
        </div>
      </div>
      <ion-fab vertical="bottom" horizontal="end" slot="fixed">
        <ion-fab-button @click="refreshUsers">
          <ion-icon name="refresh"></ion-icon>
        </ion-fab-button>
      </ion-fab>
    </ion-content>
  </ion-page>
</template>

<script>
import {
  IonPage, IonContent, IonHeader, IonToolbar, IonButtons, IonBackButton, IonTitle, IonImg, IonFab, IonFabButton, IonIcon, IonButton
} from '@ionic/vue';
import api from '../services/api';

export default {
  components: {
    IonPage,
    IonContent,
    IonHeader,
    IonToolbar,
    IonButtons,
    IonBackButton,
    IonTitle,
    IonImg,
    IonFab, 
    IonFabButton, 
    IonIcon,
    IonButton
  },
  data() {
    return {
      user: {}
    };
  },
  computed: {
    imageUrl() {
      return `http://127.0.0.1:8000/ImageContact/${this.user.image}`;
    }
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
    confirmDelete() {
      if (confirm("Voulez-vous vraiment supprimer cet utilisateur?")) {
        this.deleteUser();
      }
    },
    deleteUser() {
      api.deleteUser(this.$route.params.id)
        .then(() => {
          this.$router.push({ name: 'UserList' });
        })
        .catch(error => {
          console.error('Erreur lors de la suppression de l\'utilisateur :', error);
        });
    },
    refreshUsers() {
      this.fetchUser();
    },
    beforeRouteEnter(to, from, next) {
      next(vm => {
        vm.fetchUsers();
      });
    },
    navigateToUserList() {
      this.$router.push({ name: 'UserList' });
    }
  }
};
</script>

<style scoped>
.user-image {
  width: 150px;
  height: 150px;
  border-radius: 50%;
}

.user-info {
  display: flex;
  align-items: center;
}

.user-details {
  margin-left: 20px;
}

.user-actions {
  margin-top: 20px;
  display: flex;
  justify-content: space-between;
}
</style>