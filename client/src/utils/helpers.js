function uniqNames (arr, attribute) {
  const unique = arr.map(e => e[attribute])
    .map((e, i, final) => (final.indexOf(e) === i) && i)
    .filter((e) => arr[e]).map(e => arr[e])
  return unique
}

export { uniqNames };
