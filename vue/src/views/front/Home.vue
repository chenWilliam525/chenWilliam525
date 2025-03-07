
<template>
  <div class="main-content">
    <el-carousel :interval="4000" type="card" height="300px">
      <el-carousel-item v-for="item in carouselData" :key="item">
        <img :src="item" alt="" style="height: 300px">
      </el-carousel-item>
    </el-carousel>
    <div style="text-align: center; font-size: 22px; color: #666666; margin-top: 30px">
      高档小区 一流物业 诚挚为您服务
    </div>
    <div style="text-align: center; margin: 30px 0">
      <img src="@/assets/imgs/complaint.jpg" alt="" style="width: 250px; height: 250px; border-radius: 10px; cursor: pointer" @click="navTo('/front/complaint')">
      <img src="@/assets/imgs/activity.jpg" alt="" style="width: 250px; height: 250px; border-radius: 10px; cursor: pointer; margin: 0 40px" @click="navTo('/front/activity')">
      <img src="@/assets/imgs/fixed.jpg" alt="" style="width: 250px; height: 250px; border-radius: 10px; cursor: pointer" @click="navTo('/front/fixed')">
    </div>
  </div>
</template>

<script>

export default {

  data() {
    return {
      carouselData: [
        require('@/assets/imgs/lun-1.jpg'),
        require('@/assets/imgs/lun-2.jpg'),
        require('@/assets/imgs/lun-3.jpg'),
      ]
    }
  },
  mounted() {

  },
  // methods：本页面所有的点击事件或者其他函数定义区
  methods: {
    navTo(url) {
      location.href = url
    }
  }
}
</script>
