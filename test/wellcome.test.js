'use strict';

import assert from 'power-assert';

import wellcome from '../src/scripts/wellcome';

describe('wellcome test', () => {
    it('wellcome this page', () => {
        assert(wellcome('this page') === 'wellcome this page !');
    });
});
