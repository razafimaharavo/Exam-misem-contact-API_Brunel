<!-- <template>
    <ion-card>
      <img :src="imageUrl" alt="User Image" />
      <ion-card-header>
        <ion-card-title>{{ user.name }}</ion-card-title>
        <ion-card-subtitle>{{ user.first_name }}</ion-card-subtitle>
      </ion-card-header>
      <ion-card-content>
        <p>{{ user.numTel }}</p>
        <ion-button :router-link="{ name: 'userDetail', params: { id: user.id } }">Details</ion-button>
      </ion-card-content>
    </ion-card>
  </template>
  
  <script>
  export default {
    props: {
      user: {
        type: Object,
        required: true
      }
    },
    computed: {
      imageUrl() {
        return `http://127.0.0.1:8000/ImageContact/${this.user.image}`;
      }
    }
  };
  </script>
   -->


   <template>
    <ion-card class="user-card">
      <ion-card-header>
        <ion-card-title>{{ user.name }}</ion-card-title>
        <ion-card-subtitle>{{ user.first_name }}</ion-card-subtitle>
      </ion-card-header>
      <ion-card-content>
        <ion-img :src="imageUrl" alt="User Image" class="user-image" />
        <p>{{ user.numTel }}</p>
        <ion-button :router-link="{ name: 'userDetail', params: { id: user.id } }" expand="block">Details</ion-button>
      </ion-card-content>
    </ion-card>
  </template>
  
  <script>
  import { IonCard, IonCardHeader, IonCardTitle, IonCardSubtitle, IonCardContent, IonImg, IonButton } from '@ionic/vue';
  
  export default {
    name: 'UserCard',
    components: {
      IonCard,
      IonCardHeader,
      IonCardTitle,
      IonCardSubtitle,
      IonCardContent,
      IonImg,
      IonButton
    },
    props: {
      user: {
        type: Object,
        required: true
      }
    },
    computed: {
      imageUrl() {
        return `http://127.0.0.1:8000/ImageContact/${this.user.image}`;
      }
    }
  };
  </script>
  