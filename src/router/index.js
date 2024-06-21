// import { createRouter, createWebHistory } from '@ionic/vue-router';
// import HomePage from '../views/HomePage.vue'

// const routes= [
//   {
//     path: '/',
//     redirect: '/home'
//   },
//   {
//     path: '/home',
//     name: 'Home',
//     component: HomePage
//   }
// ]

// const router = createRouter({
//   history: createWebHistory(import.meta.env.BASE_URL),
//   routes
// })

// export default router


import { createRouter, createWebHistory } from '@ionic/vue-router';
import Home from '../views/HomePage.vue';
import UserList from '../views/UserList.vue';
import UserDetail from '@/views/UserDetail.vue';
import UserCreate from '../views/UserCreate.vue';
import UserEdit from '../views/UserEdit.vue';
import Register from '../Auth/Register.vue';
import Login from '../Auth/Login.vue';

const routes = [
  { path: '/register', component: Register },
  { path: '/login', name: 'Login', component: Login },
  { path: '/', redirect: '/login' },
  { path: '/:catchAll(.*)', redirect: '/login' },

  { path: '/home', name: 'HomePage', component: Home },
  { path: '/users', name: 'UserList', component: UserList },
  { path: '/users/:id', name: 'userDetail', component: UserDetail, props: true },
  { path: '/users/create', name: 'UserCreate', component: UserCreate },
  { path: '/users/edit/:id', name: 'UserEdit', component: UserEdit }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

router.beforeEach((to, from, next) => {
  const publicPages = ['/login', '/register'];
  const authRequired = !publicPages.includes(to.path);
  const loggedIn = localStorage.getItem('token');

  if (authRequired && !loggedIn) {
    return next('/login');
  }

  next();
});

export default router;
