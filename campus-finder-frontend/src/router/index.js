import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import('@/views/auth/LoginView.vue'),
    meta: { requiresAuth: false, title: '登录' }
  },
  {
    path: '/register',
    name: 'Register',
    component: () => import('@/views/auth/RegisterView.vue'),
    meta: { requiresAuth: false, title: '注册' }
  },
  {
    path: '/',
    component: () => import('@/layouts/MainLayout.vue'),
    meta: { requiresAuth: true },
    children: [
      {
        path: '',
        redirect: '/home'
      },
      {
        path: 'home',
        name: 'Home',
        component: () => import('@/views/HomeView.vue'),
        meta: { title: '首页' }
      },
      {
        path: 'profile',
        name: 'Profile',
        component: () => import('@/views/user/ProfileView.vue'),
        meta: { title: '个人资料' }
      },
      // 失物招领模块
      {
        path: 'lost-found',
        name: 'LostFoundList',
        component: () => import('@/views/lost/LostFoundListView.vue'),
        meta: { title: '失物招领' }
      },
      {
        path: 'lost-found/publish',
        name: 'PublishLostFound',
        component: () => import('@/views/lost/PublishLostFoundView.vue'),
        meta: { title: '发布失物招领' }
      },
      {
        path: 'lost-found/edit/:id',
        name: 'EditLostFound',
        component: () => import('@/views/lost/EditLostFoundView.vue'),
        meta: { title: '编辑物品' }
      },
      {
        path: 'lost-found/:id',
        name: 'LostFoundDetail',
        component: () => import('@/views/lost/LostFoundDetailView.vue'),
        meta: { title: '物品详情' }
      },
      {
        path: 'lost-found/my-publish',
        name: 'MyPublish',
        component: () => import('@/views/lost/MyPublishView.vue'),
        meta: { title: '我的发布' }
      },
      {
        path: 'lost-found/my-claims',
        name: 'MyClaims',
        component: () => import('@/views/lost/MyClaimsView.vue'),
        meta: { title: '我的申请' }
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*',
    redirect: '/home'
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, _from, next) => {
  const token = localStorage.getItem('accessToken')
  document.title = `${to.meta.title || '校园失物招领'} - Campus Finder`

  if (to.meta.requiresAuth !== false && !token) {
    next({ path: '/login', query: { redirect: to.fullPath } })
  } else if ((to.name === 'Login' || to.name === 'Register') && token) {
    next('/home')
  } else {
    next()
  }
})

export default router
