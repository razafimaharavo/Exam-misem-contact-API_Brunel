<!-- <template>
    <div class="user-detail">
        <h1 class="Title">Detail d'utilisateur</h1>
        <div class="user-info">
            <p><strong>Name:</strong> {{ user.name }}</p>
            <p><strong>Email:</strong> {{ user.numTel }}</p>
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
</script> -->

<template>
  <div class="user-detail">
      <h1 class="Title">Detail d'utilisateur</h1>
      <div class="user-info">
          <img :src="imageUrl" alt="User Image" class="user-image" />
          <p><strong>Name:</strong> {{ user.name }}</p>
          <p><strong>Email:</strong> {{ user.numTel }}</p>
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
          return `${process.env.VUE_APP_API_URL}/storage/ImageContact/${this.user.image}`;
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
  width: 150px; /* Adjust as needed */
  height: 150px; /* Adjust as needed */
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

<!-- 
<template>
  <div class="container user-detail">
    <h1 class="text-center">Détails </h1>
    <div class="user-info">
      <p class="btn-danger"><strong>Nom:</strong> {{ user.Name }}</p>
      <p><strong>Email:</strong> {{ user.Email }}</p>
    </div>
    <div class="user-actions d-flex justify-content-between align-items-center">
      <router-link :to="{ name: 'UserEdit', params: { id: user.id } }" class="btn btn-success">Éditer</router-link>
      <div>
        <button @click="confirmDelete" class="btn btn-danger mr-2">Supprimer</button>
        <router-link to="/users" class="btn btn-primary">Retour</router-link>
      </div>
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
    body{
        background-color: black;
    }
</style> -->

