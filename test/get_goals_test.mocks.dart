// Mocks generated by Mockito 5.4.0 from annotations
// in goals_tracker/test/get_goals_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:goals_tracker/application/adapters/igoal_repository.dart'
    as _i3;
import 'package:goals_tracker/domain/entities/goal.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGoal_0 extends _i1.SmartFake implements _i2.Goal {
  _FakeGoal_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IGoalRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockIGoalRepository extends _i1.Mock implements _i3.IGoalRepository {
  MockIGoalRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void save(_i2.Goal? goal) => super.noSuchMethod(
        Invocation.method(
          #save,
          [goal],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<List<_i2.Goal>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Goal>>.value(<_i2.Goal>[]),
      ) as _i4.Future<List<_i2.Goal>>);
  @override
  _i4.Future<_i2.Goal> getById(String? id) => (super.noSuchMethod(
        Invocation.method(
          #getById,
          [id],
        ),
        returnValue: _i4.Future<_i2.Goal>.value(_FakeGoal_0(
          this,
          Invocation.method(
            #getById,
            [id],
          ),
        )),
      ) as _i4.Future<_i2.Goal>);
  @override
  void update(_i2.Goal? goal) => super.noSuchMethod(
        Invocation.method(
          #update,
          [goal],
        ),
        returnValueForMissingStub: null,
      );
}
