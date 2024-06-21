<!-- <template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-title>Liste des contacts</ion-title>
        </ion-toolbar>
      </ion-header>
      <ion-content>
        <ion-spinner v-if="loading"></ion-spinner>
        <div v-else>
          <UserCard v-for="user in users" :key="user.id" :user="user" />
        </div>
        <ion-button :router-link="{ name: 'Home' }">Retour</ion-button>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import api from '../services/api';
  import UserCard from '@/components/UserCard.vue';
  
  export default {
    components: {
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
        api.getUsers()
          .then(response => {
            this.users = response.data;
            this.loading = false;
          })
          .catch(error => {
            console.error('Erreur lors du chargement des utilisateurs :', error);
            this.loading = false;
          });
      }
    }
  };
  </script>
  
  -->


  <template>
    <ion-page>
      <ion-header>
        <ion-toolbar>
          <ion-buttons slot="start">
            <ion-back-button defaultHref="/home" text="Retour"></ion-back-button>
          </ion-buttons>
          <ion-title>Liste des contact</ion-title>
        </ion-toolbar>
      </ion-header> 

      <ion-content class="ion-padding">
        <div v-if="loading" class="loading-message">
          <ion-text color="primary">
            <h4>Loading ...</h4>
          </ion-text>
        </div>
        <div v-else class="user-list">
          <UserCard v-for="user in users" :key="user.id" :user="user" />
        </div>
        <ion-button :router-link="{ name: 'HomePage' }" expand="block">Retour</ion-button>
      </ion-content>
    </ion-page>
  </template>
  
  <script>
  import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButtons, IonBackButton, IonText, IonButton } from '@ionic/vue';
  import api from '../services/api';
  import UserCard from '@/components/UserCard.vue';
  
  export default {
    name: 'UserList',
    components: {
      IonPage,
      IonHeader,
      IonToolbar,
      IonTitle,
      IonContent,
      IonButtons,
      IonBackButton,
      IonText,
      IonButton,
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
      async fetchUsers() {
        try {
          const response = await api.getUsers();
          this.users = response.data;
          this.loading = false;
        } catch (error) {
          console.error('Erreur lors du chargement des utilisateurs :', error);
          this.loading = false;
        }
      }
    }
  };
  </script>
  
  <style scoped>
.user-list-container {
    max-width: 800px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    text-align: center;
    background-color: rgba(2, 1, 24, 0.5); 
}

.loading-message {
    margin-top: 20px;
}

.user-list {
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
    justify-content: center;
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
