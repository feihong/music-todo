/* Run this on a YouTube playlist page to extract basic metadata
*/

let result =
  [...document.querySelectorAll('#meta.ytd-playlist-video-renderer')]
  .map(node => {
    return [
      node.querySelector('#video-title').innerText,
      node.querySelector('#channel-name').innerText,
    ]
  })
  .map(([title, artist]) => `${title}  ${artist}`)
  .join('\n')
console.log(result)
