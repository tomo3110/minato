import './wiki-user-photo';

<wiki-comment-field>
  <wiki-user-photo src={ opts.photo_src } size='50px'></wiki-user-photo>
  <form class='comment-form' onsubmit={ onsubmit }>
    <textarea name='comment_input' placeholder='Leave a comment'>{comment}</textarea>
    <button type='submit'>submit</button>
  </form>

  <script>
    this.mixin('control');

    onsubmit(e) {
      e.preventDefault();
      this.control.trigger('comment-post', {comment: this.comment_input.value, key: opts.key});
      this.comment_input.value = '';
    }
  </script>

  <style scoped>
    :scope {
      display: flex;
    }
    :scope wiki-user-photo {
      margin: 1.5rem;
    }
    :scope form.comment-form {
      flex: 1;
      margin: 0;
      display: flex;
      flex-direction: column;
    }
    :scope form.comment-form > textarea {
      flex: 1;
      margin: 0;
      height: 5rem;
      font-size: 1.5rem;
      border-style: none;
    }
    :scope form.comment-form > button {
      margin: 0;
      margin-top: 1rem;
      line-height: 0;
      font-size: 1rem;
      width: 100%;
      height: 3rem;
      border: solid thin #0094ff;
      color: #0094ff;
    }
    :scope form.comment-form > button:hover {
      background-color: #0094ff;
      color: #fff;
    }
  </style>
</wiki-comment-field>
