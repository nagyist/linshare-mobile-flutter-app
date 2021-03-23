// LinShare is an open source filesharing software, part of the LinPKI software
// suite, developed by Linagora.
//
// Copyright (C) 2020 LINAGORA
//
// This program is free software: you can redistribute it and/or modify it under the
// terms of the GNU Affero General Public License as published by the Free Software
// Foundation, either version 3 of the License, or (at your option) any later version,
// provided you comply with the Additional Terms applicable for LinShare software by
// Linagora pursuant to Section 7 of the GNU Affero General Public License,
// subsections (b), (c), and (e), pursuant to which you must notably (i) retain the
// display in the interface of the “LinShare™” trademark/logo, the "Libre & Free" mention,
// the words “You are using the Free and Open Source version of LinShare™, powered by
// Linagora © 2009–2020. Contribute to Linshare R&D by subscribing to an Enterprise
// offer!”. You must also retain the latter notice in all asynchronous messages such as
// e-mails sent with the Program, (ii) retain all hypertext links between LinShare and
// http://www.linshare.org, between linagora.com and Linagora, and (iii) refrain from
// infringing Linagora intellectual property rights over its trademarks and commercial
// brands. Other Additional Terms apply, see
// <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf>
// for more details.
// This program is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
// more details.
// You should have received a copy of the GNU Affero General Public License and its
// applicable Additional Terms for LinShare along with this program. If not, see
// <http://www.gnu.org/licenses/> for the GNU Affero General Public License version
//  3 and <http://www.linshare.org/licenses/LinShare-License_AfferoGPL-v3.pdf> for
//  the Additional Terms applicable to LinShare software.

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:testshared/testshared.dart';

void main() {
  group('sort_data_source_impl getSorter test', () {
    SortDataSourceImpl _sortDataSourceImpl;

    test(
        'getSorter should return success with order_by is modificationDate & order_type is descending saved',
        () async {
      SharedPreferences.setMockInitialValues({
        'sort_file_order_by_${sorter.orderScreen.toString()}':
            OrderBy.modificationDate.toString(),
        'sort_file_order_type_${sorter.orderScreen.toString()}':
            OrderType.descending.toString()
      });

      final _sharedPreferences = await SharedPreferences.getInstance();

      _sortDataSourceImpl = SortDataSourceImpl(_sharedPreferences);

      final result = await _sortDataSourceImpl.getSorter(sorter.orderScreen);

      expect(
          _sharedPreferences
              .getString('sort_file_order_by_${sorter.orderScreen.toString()}'),
          result.orderBy.toString());
      expect(
          _sharedPreferences.getString(
              'sort_file_order_type_${sorter.orderScreen.toString()}'),
          result.orderType.toString());
    });

    test(
        'getSorter should return success with order_by is creationDate & order_type is descending saved',
        () async {
      SharedPreferences.setMockInitialValues({
        'sort_file_order_by_${sorter.orderScreen.toString()}':
            OrderBy.creationDate.toString(),
        'sort_file_order_type_${sorter.orderScreen.toString()}':
            OrderType.descending.toString()
      });

      final _sharedPreferences = await SharedPreferences.getInstance();

      _sortDataSourceImpl = SortDataSourceImpl(_sharedPreferences);

      final result = await _sortDataSourceImpl.getSorter(sorter1.orderScreen);

      expect(
          _sharedPreferences.getString(
              'sort_file_order_by_${sorter1.orderScreen.toString()}'),
          result.orderBy.toString());
      expect(
          _sharedPreferences.getString(
              'sort_file_order_type_${sorter1.orderScreen.toString()}'),
          result.orderType.toString());
    });

    test(
        'sortFiles should return success with list file has been sorted modification date',
        () async {
      SharedPreferences.setMockInitialValues({});

      final _sharedPreferences = await SharedPreferences.getInstance();

      _sortDataSourceImpl = SortDataSourceImpl(_sharedPreferences);

      final result = await _sortDataSourceImpl
          .sortFiles([documentSort1, documentSort2, documentSort3], sorter);
      expect(result, [documentSort3, documentSort2, documentSort1]);
    });
  });

  group('sort_data_source_impl saveSorter test', () {
    SortDataSourceImpl _sortDataSourceImpl;

    test(
        'saveSorter should return success with order_by is modificationDate & order_type is descending saved',
        () async {
      SharedPreferences.setMockInitialValues({});

      final _sharedPreferences = await SharedPreferences.getInstance();

      _sortDataSourceImpl = SortDataSourceImpl(_sharedPreferences);

      await _sharedPreferences.setString(
          'sort_file_order_by_${sorter.orderScreen.toString()}',
          OrderBy.modificationDate.toString());
      await _sharedPreferences.setString(
          'sort_file_order_type_${sorter.orderScreen.toString()}',
          OrderType.descending.toString());

      final result = await _sortDataSourceImpl.saveSorter(sorter);

      expect(
          _sharedPreferences
              .getString('sort_file_order_by_${sorter.orderScreen.toString()}'),
          result.orderBy.toString());
      expect(
          _sharedPreferences.getString(
              'sort_file_order_type_${sorter.orderScreen.toString()}'),
          result.orderType.toString());
    });

    test(
        'saveSorter should return success with order_by is creationDate & order_type is descending saved',
        () async {
      SharedPreferences.setMockInitialValues({});

      final _sharedPreferences = await SharedPreferences.getInstance();

      _sortDataSourceImpl = SortDataSourceImpl(_sharedPreferences);

      await _sharedPreferences.setString(
          'sort_file_order_by_${sorter1.orderScreen.toString()}',
          OrderBy.creationDate.toString());
      await _sharedPreferences.setString(
          'sort_file_order_type_${sorter1.orderScreen.toString()}',
          OrderType.descending.toString());

      final result = await _sortDataSourceImpl.saveSorter(sorter1);

      expect(
          _sharedPreferences.getString(
              'sort_file_order_by_${sorter1.orderScreen.toString()}'),
          result.orderBy.toString());
      expect(
          _sharedPreferences.getString(
              'sort_file_order_type_${sorter1.orderScreen.toString()}'),
          result.orderType.toString());
    });
  });
}