<template>
  <ion-card class="user-card">
    <ion-card-content class="user-info">
      <ion-img :src="imageUrl" alt="User Image" class="user-image" />
      <div class="user-details">
        <ion-card-title class="user-name">{{ user.name }}</ion-card-title>
        <ion-card-subtitle class="user-first-name">{{ user.first_name }}</ion-card-subtitle>
        <ion-card-title class="user-num">{{ user.numTel }}</ion-card-title>
      </div>
      <ion-button :router-link="{ name: 'userDetail', params: { id: user.id } }" fill="outline" size="small" class="detail-link">Détails</ion-button>
    </ion-card-content>
  </ion-card>
</template>


<script>
import { IonCard, IonCardTitle, IonCardSubtitle, IonCardContent, IonImg, IonButton } from '@ionic/vue';

export default {
  name: 'UserCard',
  components: {
    IonCard,
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

<style scoped>
.user-card {
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  background-color: rgba(12, 187, 245, 0.7);
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  max-width: 400px;
  margin: 10px auto;
}

.user-card:nth-child(odd) {
    background-color: rgba(54, 99, 158, 0.7);
}

.user-info {
  display: flex;
  align-items: center;
  width: 100%;
}

.user-image {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  margin-right: 20px;
}

.user-details {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  flex-grow: 1;
}

.user-num {
  font-size: 14px;
  margin-bottom: 5px;
}

.user-name {
  font-size: 16px;
  margin: 0;
}

.user-first-name {
  font-size: 14px;
  color: #666;
}

.detail-link {
  margin-left: auto;
}
</style>
