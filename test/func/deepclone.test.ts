import { expect } from 'chai';
import { deepClone } from '../../src/func/deepclone';

describe('test deepclone (typescript / livescript)', (): void => {

    let before: any;

    beforeEach((): void => {
        before = {
            aBoolean: true,
            aNumber: 16,
            aString: 'hello',
            anArray: [
                'whooo',
                45,
            ],
        };
    });

    it('deep cloned object should be deep equal to before', (): void => {
        const clonedBefore = deepClone(before);
        expect(before).to.be.deep.equal(clonedBefore);
    });

    it('deep cloned object should be pointer equal to before', (): void => {
        const clonedBefore = deepClone(before);
        expect(before).to.be.not.equal(clonedBefore);
    });
});
