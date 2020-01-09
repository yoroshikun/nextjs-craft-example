/**
 * Gets the Live preview token from the path you give it
 * @param path Path string to seatch for token in
 * @return String of token or null if no token present
 */
const getLivePreviewToken = (path: string): string => {
  if (path.includes('x-craft-live-preview')) {
    // Search for livePreviewToken
    let m = path.match(/\btoken=([^&]+)/);
    // Return second matched element (the token)
    return m && m[1] ? m[1] : null;
  }

  return null;
};

export default getLivePreviewToken;
