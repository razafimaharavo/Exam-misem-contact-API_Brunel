<!-- <template>
  <div class="user-detail">
      <h1 class="Title">Detail d'utilisateur</h1>
      <div class="user-info">
          <img :src="imageUrl" alt="User Image" class="user-image" />
          <p><strong>Nom:</strong> {{ user.name }}</p>
          <p><strong>Pénom:</strong> {{ user.first_name }}</p>
          <p><strong>Numéro téléphone:</strong> {{ user.numTel }}</p>
      </div>
      <div class="user-actions">
          <router-link :to="{ name: 'UserEdit', params: { id: user.id } }" class="edit-link">Edit</router-link>
          <button @click="confirmDelete" class="delete-button">Delete</button>
      </div>
      <router-link to="/users" class="back-link">Retour</router-link>
  </div>
</template>

<script>
import api from '../services/api';

export default {
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
      api.getUser(this.$route.params.id).then(response => {
          this.user = response.data;
      });
  },
  methods: {
      confirmDelete() {
          if (confirm("Voulez vous supprimer vraiment cet utilisateur?")) {
              this.deleteUser();
          }
      },
      deleteUser() {
          api.deleteUser(this.$route.params.id).then(() => {
              this.$router.push('/users');
          });
      }
  }
};
</script>


<style scoped>

.user-image {
  width: 150px; 
  height: 150px; 
  object-fit: cover;
}

.Title {
    text-align: center;
}
.user-detail {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
    background-color: rgba(0, 0, 0, 0.6);
}

.user-info {
    margin-bottom: 20px;
}

.user-info p {
    margin: 10px 0;
}

.user-actions {
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
}

.edit-link,
.delete-button,
.back-link {
    padding: 10px 20px;
    text-decoration: none;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

.edit-link {
    background-color: #4caf50;
    color: white;
}

.delete-button {
    background-color: #f44336;
    color: white;
}

.back-link {
    display: inline-block;
    background-color: #2196f3;
    color: white;
}
</style>
 -->


 <template>
    <div class="user-detail">
      <h1 class="title">Détails du contact</h1>
      <div class="user-info">
        <img :src="imageUrl" alt="User Image" class="user-image" />
        <div class="user-details">
          <p>Nom: <strong>{{ user.name }}</strong> </p>
          <p>Prénom: <strong>{{ user.first_name }}</strong></p>
          <p>Numéro téléphone: <strong>{{ user.numTel }}</strong></p>
        </div>
      </div>
      <div class="user-actions">
        <router-link :to="{ name: 'UserEdit', params: { id: user.id } }" class="edit-link">Edit</router-link>
        <button @click="confirmDelete" class="delete-button">Delete</button>
        <router-link to="/users" class="back-link">Retour</router-link>
      </div>
    </div>
  </template>
  
  <script>
  import api from '../services/api';
  
  export default {
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
      api.getUser(this.$route.params.id).then(response => {
        this.user = response.data;
      });
    },
    methods: {
      confirmDelete() {
        if (confirm("Voulez-vous vraiment supprimer cet utilisateur?")) {
          this.deleteUser();
        }
      },
      deleteUser() {
        api.deleteUser(this.$route.params.id).then(() => {
          this.$router.push('/users');
        });
      }
    }
  };
  </script>
  
  <style scoped>
  .user-detail {
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.5);
    background-color: rgba(2, 1, 24, 0.9); 
    position: relative;
    top: 8pc;
  }
  
  .title {
    text-align: center;
  }
  
  .user-info {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
  }
  
  .user-image {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    margin-right: 20px;
  }
  
  .user-details {
    flex: 1;
  }
  
  .user-info p {
    margin: 10px 0;
  }
  
  .user-actions {
    display: flex;
    justify-content: space-around;
    margin-top: 20px;
  }
  
  .edit-link,
  .delete-button,
  .back-link {
    padding: 6px 20px;
    text-decoration: none;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    color: white; 
  }
  
  .edit-link {
    background-color: #4caf50;
  }
  
  .delete-button {
    background-color: #f44336;
  }
  
  .back-link {
    background-color: #2196f3;
    display: inline-block;
    text-align: center;
  }
  </style>
  