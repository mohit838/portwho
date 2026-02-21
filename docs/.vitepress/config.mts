import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'portwho',
  description: 'Linux CLI to find which process is listening on a port',
  lastUpdated: true,
  themeConfig: {
    siteTitle: 'portwho docs',
    nav: [
      { text: 'Guide', link: '/guide/getting-started' },
      { text: 'Reference', link: '/reference/cli' },
      { text: 'GitHub', link: 'https://github.com/mohit838/portwho' }
    ],
    sidebar: {
      '/guide/': [
        {
          text: 'Guide',
          items: [
            { text: 'Getting Started', link: '/guide/getting-started' },
            { text: 'Usage', link: '/guide/usage' },
            { text: 'Contributing', link: '/guide/contributing' }
          ]
        }
      ],
      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'CLI', link: '/reference/cli' },
            { text: 'Debian Packaging', link: '/reference/debian-packaging' }
          ]
        }
      ]
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/mohit838/portwho' }
    ],
    footer: {
      message: 'MIT Licensed',
      copyright: 'Copyright (c) 2026 Mohitul Islam and contributors'
    }
  }
})
