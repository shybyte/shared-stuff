/* jasmine specs for controllers go here */

describe('cleanObjectFromAngular', function () {
    beforeEach(function () {

    });

    it('should remove attributes starting with $$', function () {
        var items = [{'$$bla':1,"bla":2}]
        utils.cleanObjectFromAngular(items)
        expect(items[0]).toEqual({'bla':2})
    });
});