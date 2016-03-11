(function() {
  'use strict';

  var ParticipantForm = {};
  var PASSPHRASE_LENGTH = 4;

  function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
  }

  function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
  }

  ParticipantForm.generatePassword = function() {
    var password = [];

    for (var i = 0; i < PASSPHRASE_LENGTH; i++) {
      var passwordFragment = words()[getRandomInt(0, words().length)];
      password.push(capitalizeFirstLetter(passwordFragment));
    }

    this.password = password.join(getRandomInt(0,9));
  };

  ParticipantForm.createPasswordFields = function() {
    $('#password-form-group').append(
      '<label class="well" id="password-display"></label>' +
      '<input class="hidden" id="password-value" name="participant[password]" type="password">' +
      '<input class="hidden" id="password-confirmation-value" name="participant[password_confirmation]" type="password">'
    );
  };

  ParticipantForm.setPasswordFields = function() {
    $('#password-value').val(this.password);
    $('#password-confirmation-value').val(this.password);
  };

  ParticipantForm.displayPassword = function() {
    $('#password-display').html(this.password);
  };

  $(document).on('ready page:change', function() {
    $('#password-generator').on('click', function(event) {
      event.preventDefault();
      ParticipantForm.generatePassword();
      ParticipantForm.createPasswordFields();
      ParticipantForm.setPasswordFields();
      ParticipantForm.displayPassword();
    });
  });

  function words() {
    return [
      'abash',
      'abate',
      'above',
      'acorn',
      'adapt',
      'adore',
      'after',
      'again',
      'alarm',
      'album',
      'aloft',
      'alone',
      'alpha',
      'among',
      'angle',
      'antic',
      'anvil',
      'apart',
      'apple',
      'apron',
      'arena',
      'armor',
      'aside',
      'atlas',
      'attic',
      'avian',
      'awoke',
      'bacon',
      'bagel',
      'baron',
      'basic',
      'basin',
      'basis',
      'batch',
      'baton',
      'beard',
      'beget',
      'bingo',
      'blank',
      'blaze',
      'bless',
      'blues',
      'blunt',
      'blurb',
      'boast',
      'boost',
      'booth',
      'boots',
      'bound',
      'boxer',
      'brand',
      'bread',
      'break',
      'brick',
      'brine',
      'broad',
      'brood',
      'brook',
      'brown',
      'bugle',
      'bulky',
      'bylaw',
      'cabin',
      'cable',
      'caddy',
      'camel',
      'canon',
      'capes',
      'cargo',
      'catch',
      'cedar',
      'chair',
      'chant',
      'chase',
      'check',
      'chest',
      'chewy',
      'child',
      'chips',
      'chomp',
      'chore',
      'cigar',
      'clamp',
      'class',
      'clerk',
      'climb',
      'cling',
      'cloak',
      'coach',
      'comic',
      'coral',
      'couch',
      'craft',
      'crate',
      'creek',
      'cried',
      'curse',
      'cycle'
    ];
  }
})();
