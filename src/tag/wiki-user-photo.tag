<wiki-user-photo>
  <a href={ opts.href }>
    <img src={ opts.url || './images/photo.jpg' }
      width={ opts.size } height={ opts.size } />
  </a>

  <style scoped>
    :scope img {
      border-radius: 50%;
    }
  </style>
</wiki-user-photo>
