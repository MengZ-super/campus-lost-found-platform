import { describe, it, expect, vi, beforeEach } from 'vitest'
import { mount } from '@vue/test-utils'
import MapPicker from '@/components/map-picker.vue'

describe('components/map-picker', () => {
  beforeEach(() => {
    vi.clearAllMocks()
  })

  describe('默认状态（无位置）', () => {
    it('modelValue 为空时显示占位区域', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      expect(wrapper.find('.map-placeholder').exists()).toBe(true)
      expect(wrapper.find('.map').exists()).toBe(false)
      expect(wrapper.find('.placeholder-text').text()).toBe('点击选择位置')
    })

    it('modelValue 为 undefined 时显示占位区域', () => {
      const wrapper = mount(MapPicker)

      expect(wrapper.find('.map-placeholder').exists()).toBe(true)
      expect(wrapper.find('.map').exists()).toBe(false)
    })

    it('显示"选择位置"按钮', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      const btn = wrapper.find('.btn-select')
      expect(btn.exists()).toBe(true)
      expect(btn.text()).toBe('选择位置')
    })

    it('无位置时不显示清除按钮', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      expect(wrapper.find('.btn-clear').exists()).toBe(false)
    })

    it('无位置时不显示位置信息', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      expect(wrapper.find('.location-info').exists()).toBe(false)
    })
  })

  describe('有位置状态', () => {
    const locationWithValue = {
      latitude: 39.9042,
      longitude: 116.4074,
      name: '天安门广场',
      address: '北京市东城区天安门广场'
    }

    it('有位置时显示地图', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: locationWithValue }
      })

      expect(wrapper.find('.map').exists()).toBe(true)
      expect(wrapper.find('.map-placeholder').exists()).toBe(false)
    })

    it('显示位置名称', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: locationWithValue }
      })

      const info = wrapper.find('.location-info')
      expect(info.exists()).toBe(true)
      expect(info.text()).toContain('天安门广场')
    })

    it('显示地址', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: locationWithValue }
      })

      expect(wrapper.find('.location-info').text()).toContain('北京市东城区天安门广场')
    })

    it('显示"重新选择"按钮', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: locationWithValue }
      })

      expect(wrapper.find('.btn-select').text()).toBe('重新选择')
    })

    it('显示清除按钮', () => {
      const wrapper = mount(MapPicker, {
        props: { modelValue: locationWithValue }
      })

      const clearBtn = wrapper.find('.btn-clear')
      expect(clearBtn.exists()).toBe(true)
      expect(clearBtn.text()).toBe('清除')
    })

    it('name 为空时显示"未知地点"', () => {
      const wrapper = mount(MapPicker, {
        props: {
          modelValue: { latitude: 39.9, longitude: 116.4, name: '', address: '' }
        }
      })

      expect(wrapper.find('.location-info').text()).toContain('未知地点')
    })

    it('无 address 时不显示地址行', () => {
      const wrapper = mount(MapPicker, {
        props: {
          modelValue: { latitude: 39.9, longitude: 116.4, name: '测试地点' }
        }
      })

      const infoText = wrapper.find('.location-info').text()
      expect(infoText).not.toContain('地址')
    })
  })

  describe('选择位置', () => {
    it('点击占位区域调用 uni.chooseLocation', async () => {
      uni.chooseLocation.mockImplementation(({ success }) => {
        success({
          latitude: 31.2304,
          longitude: 121.4737,
          name: '东方明珠',
          address: '上海市浦东新区'
        })
      })

      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      await wrapper.find('.map-placeholder').trigger('tap')

      expect(uni.chooseLocation).toHaveBeenCalled()
    })

    it('点击"选择位置"按钮调用 uni.chooseLocation', async () => {
      uni.chooseLocation.mockImplementation(({ success }) => {
        success({
          latitude: 31.2304,
          longitude: 121.4737,
          name: '东方明珠',
          address: '上海市浦东新区'
        })
      })

      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      await wrapper.find('.btn-select').trigger('tap')

      expect(uni.chooseLocation).toHaveBeenCalled()
    })

    it('选择成功后 emit update:modelValue', async () => {
      const locationResult = {
        latitude: 31.2304,
        longitude: 121.4737,
        name: '东方明珠',
        address: '上海市浦东新区'
      }

      uni.chooseLocation.mockImplementation(({ success }) => {
        success(locationResult)
      })

      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      await wrapper.find('.btn-select').trigger('tap')

      expect(wrapper.emitted('update:modelValue')).toBeTruthy()
      expect(wrapper.emitted('update:modelValue')[0][0]).toEqual(locationResult)
    })

    it('用户取消选择时不 emit', async () => {
      uni.chooseLocation.mockImplementation(({ fail }) => {
        fail({ errMsg: 'chooseLocation:fail cancel' })
      })

      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      await wrapper.find('.btn-select').trigger('tap')

      expect(wrapper.emitted('update:modelValue')).toBeFalsy()
    })

    it('选择失败时显示 toast', async () => {
      uni.chooseLocation.mockImplementation(({ fail }) => {
        fail({ errMsg: 'chooseLocation:fail auth deny' })
      })

      const wrapper = mount(MapPicker, {
        props: { modelValue: {} }
      })

      await wrapper.find('.btn-select').trigger('tap')

      expect(uni.showToast).toHaveBeenCalledWith({
        title: '选择位置失败',
        icon: 'none'
      })
    })
  })

  describe('清除位置', () => {
    it('点击清除按钮 emit 空对象', async () => {
      const wrapper = mount(MapPicker, {
        props: {
          modelValue: {
            latitude: 39.9042,
            longitude: 116.4074,
            name: '天安门',
            address: '北京'
          }
        }
      })

      await wrapper.find('.btn-clear').trigger('tap')

      expect(wrapper.emitted('update:modelValue')).toBeTruthy()
      expect(wrapper.emitted('update:modelValue')[0][0]).toEqual({})
    })
  })
})
