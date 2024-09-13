import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  bool allChips = true;
  bool smartCasualChip = false;
  bool uniChip = false;
  bool sportyChip = false;
  bool formalChip = false;
  bool recommendationChip = false;

  List<String> toggleChip(String chipType) {
    switch (chipType) {
      case 'all':
        _resetAllChips();
        allChips = true;
        break;
      case 'smartCasual':
        smartCasualChip = !smartCasualChip;
        break;
      case 'uni':
        uniChip = !uniChip;
        break;
      case 'sporty':
        sportyChip = !sportyChip;
        break;
      case 'formal':
        formalChip = !formalChip;
        break;
      case 'recommendation':
        recommendationChip = !recommendationChip;
        if (recommendationChip) {
          _resetAllChips();
          recommendationChip = true;
        } else {
          allChips = true;
        }
        break;
    }

    if (chipType != 'all' && chipType != 'recommendation') {
      _checkAndHandleChipSelection();
    }

    notifyListeners();
    return filtersText;
  }

  void _resetAllChips() {
    allChips = false;
    smartCasualChip = false;
    uniChip = false;
    sportyChip = false;
    formalChip = false;
    recommendationChip = false;
  }

  void _checkIfAllItemIsSelected() {
    allChips = false;
    bool allChipSelected =
        smartCasualChip && uniChip && sportyChip && formalChip;
    if (allChipSelected) {
      _resetAllChips();
      allChips = true;
    }
    if (recommendationChip) {
      recommendationChip = false;
    }
    notifyListeners();
  }

  void _checkAndHandleChipSelection() {
    bool isAllChipsSelected = false;
    bool isAnyChipSelected =
        smartCasualChip || uniChip || sportyChip || formalChip;

    if (isAnyChipSelected) {
      isAllChipsSelected =
          smartCasualChip && uniChip && sportyChip && formalChip;
      if (isAllChipsSelected) {
        _resetAllChips();
        allChips = true;
      } else {
        allChips = false;
      }
    } else {
      _resetAllChips();
      allChips = true;
    }

    if (recommendationChip) {
      recommendationChip = false;
    }

    notifyListeners();
  }

  List<String> get filtersText {
    List<String> selectedFilters = [];

    if (smartCasualChip) {
      selectedFilters.add("Smart-Casual Outfits");
    }
    if (uniChip) {
      selectedFilters.add("Uni Outfits");
    }
    if (sportyChip) {
      selectedFilters.add("Sporty Outfits");
    }
    if (formalChip) {
      selectedFilters.add("Formal Outfits");
    }
    if (recommendationChip) {
      selectedFilters.add("Recommendation Outfits");
    }

    if (selectedFilters.isEmpty) {
      selectedFilters.add("All");
    }
    return selectedFilters;
  }
}
