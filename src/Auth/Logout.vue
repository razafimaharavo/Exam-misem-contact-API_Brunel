  <template>
    <ion-button @click="logout">Logout</ion-button>
  </template>
  
  <script>
  import { IonButton } from '@ionic/vue';
  import axios from 'axios';
  
  export default {
    name: 'UserLogout',
    components: {
      IonButton
    },
    methods: {
      async logout() {
        try {
          const token = localStorage.getItem('token');
          await axios.post('http://localhost:8000/api/logout', {}, {
            headers: {
              'Authorization': `Bearer ${token}`
            }
          }).then(() => {
            localStorage.removeItem('token');
            this.$router.push('/login');
          });
        } catch (error) {
          console.error(error.response.data);
        }
      }
    }
  };
  </script>
  