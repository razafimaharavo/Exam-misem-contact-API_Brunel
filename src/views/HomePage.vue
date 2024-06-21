<!-- <template>
  <ion-page>
    <ion-header :translucent="true">
      <ion-toolbar>
        <ion-title>Blank</ion-title> 
      </ion-toolbar>
    </ion-header>

    <ion-content :fullscreen="true">
      <ion-header collapse="condense">
        <ion-toolbar>
          <ion-title size="large">Blank</ion-title>
        </ion-toolbar>
      </ion-header>

      <div id="container">
        <strong>Ready to create an app?</strong>
        <p>Start with Ionic <a target="_blank" rel="noopener noreferrer" href="https://ionicframework.com/docs/components">UI Components</a></p>
      </div>
    </ion-content>
  </ion-page>
</template>

<script setup>
import { IonContent, IonHeader, IonPage, IonTitle, IonToolbar } from '@ionic/vue';
</script>

<style scoped>
#container {
  text-align: center;
  
  position: absolute;
  left: 0;
  right: 0;
  top: 50%;
  transform: translateY(-50%);
}

#container strong {
  font-size: 20px;
  line-height: 26px;
}

#container p {
  font-size: 16px;
  line-height: 22px;
  
  color: #8c8c8c;
  
  margin: 0;
}

#container a {
  text-decoration: none;
}
</style> -->


<!-- <template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Accueil</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content>
      <ion-button :router-link="{ name: 'UserList' }">Voir la liste des utilisateurs</ion-button>
      <ion-button :router-link="{ name: 'UserCreate' }">Ajouter un utilisateur</ion-button>
      <footer>
        <Logout />
      </footer>
    </ion-content>
  </ion-page>
</template>

<script>
import Logout from '@/Auth/Logout.vue'; 

export default {
  name: 'Home',
  components: {
    Logout
  }
}
</script> -->


<template>
  <ion-page>
    <ion-header>
      <ion-toolbar>
        <ion-title>Accueil</ion-title>
      </ion-toolbar>
    </ion-header>
    <ion-content class="ion-padding">
      <router-link :to="{ name: 'UserList' }"><ion-button expand="block">Voir la liste
          des utilisateurs</ion-button></router-link>
      <!-- <router-link :to="{ name: 'UserCreate' }"><ion-button expand="block">Ajouter un
          utilisateur</ion-button></router-link> -->
          <router-link to="/users/create" class="link"><ion-button expand="block">Ajouter un
            utilisateur</ion-button></router-link>
      <ion-footer>
        <Logout />
      </ion-footer>
    </ion-content>
  </ion-page>
</template>

<script>
import { IonPage, IonHeader, IonToolbar, IonTitle, IonContent, IonButton, IonFooter } from '@ionic/vue';
import Logout from '@/Auth/Logout.vue';

export default {
  name: 'HomePage',
  components: {
    IonPage,
    IonHeader,
    IonToolbar,
    IonTitle,
    IonContent,
    IonButton,
    IonFooter,
    Logout
  }
};
</script>
