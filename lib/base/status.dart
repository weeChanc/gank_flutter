// a constant wrapper for example warp TabType
class Status<E> {
  E val;

  Status(this.val);

  bool operator ==(other) {
    if (!other is E) return false;
    return this.val == other.val;
  }

  @override
  int get hashCode {
    return val.hashCode;
  }
}
