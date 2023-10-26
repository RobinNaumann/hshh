extension MaypeMap<A, B> on Map<A, B> {
  maybe(A key) => containsKey(key) ? this[key] : null;
}
