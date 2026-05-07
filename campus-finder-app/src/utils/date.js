export function formatDate(date) {
  if (!date) return ''
  const d = new Date(date)
  const y = d.getFullYear()
  const m = String(d.getMonth() + 1).padStart(2, '0')
  const day = String(d.getDate()).padStart(2, '0')
  return `${y}-${m}-${day}`
}

export function relativeTime(date) {
  if (!date) return ''
  const now = Date.now()
  const then = new Date(date).getTime()
  const diff = now - then

  if (diff < 0) return '刚刚'

  const seconds = Math.floor(diff / 1000)
  if (seconds <= 30) return '刚刚'

  const minutes = Math.floor(seconds / 60)
  if (minutes < 60) return `${minutes}分钟前`

  const hours = Math.floor(minutes / 60)
  if (hours < 24) return `${hours}小时前`

  const days = Math.floor(hours / 24)
  if (days <= 30) return `${days}天前`

  return formatDate(date)
}
