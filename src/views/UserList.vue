<!-- <template>
    <div class="user-list-container">
        <h1>Liste d'utilisateurs</h1>
        <div v-if="loading" class="loading-message">
            <br> <h4>Loading ...</h4><br>
        </div>
        <div v-else class="user-list">
            <UserCard v-for="user in users" :key="user.id" :user="user" />
        </div>
        <router-link to="/" class="back-link">Retour</router-link>
    </div>
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
                    this.loading = false; // Mettre loading à false une fois les données chargées
                })
                .catch(error => {
                    console.error('Erreur lors du chargement des utilisateurs :', error);
                    this.loading = false; // Mettre loading à false en cas d'erreur
                });
        }
    }
};
</script> -->

<template>
    <div class="user-list-container">
        <h1>Liste d'utilisateurs</h1>
        <div v-if="loading" class="loading-message">
            <br> <h4>Loading ...</h4><br>
        </div>
        <div v-else class="user-list">
            <UserCard v-for="user in users" :key="user.id" :user="user" />
        </div>
        <router-link to="/" class="back-link">Retour</router-link>
    </div>
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
                    this.loading = false; // Mettre loading à false une fois les données chargées
                })
                .catch(error => {
                    console.error('Erreur lors du chargement des utilisateurs :', error);
                    this.loading = false; // Mettre loading à false en cas d'erreur
                });
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
    background-color: transparent;
    text-align: center;
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
<!-- 
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
        api.getUsers().then(response => {
            this.users = response.data;
            this.loading = false;
        });
    }
};
</script>


<template>
    <div class="container">
        <h1 class="my-4">Liste d'utilisateurs</h1>
        <router-link to="/" class="btn btn-primary mt-4">Retour</router-link>
        <div v-if="loading" class="my-4">
            <h4>Loading ...</h4>
        </div>
        <div v-else class="row">
            <UserCard v-for="user in users" :key="user.id" :user="user" class="col-md-4 " />
        </div>
        
    </div>
</template>

<style scoped>


</style>


 -->
