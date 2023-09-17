// ignore_for_file: must_be_immutable

abstract class SearchEvent {
  SearchEvent();
}

class OnQueryChanged extends SearchEvent {
  String query = '';
  OnQueryChanged(this.query);
}
