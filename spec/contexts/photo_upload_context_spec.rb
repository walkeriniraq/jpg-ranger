require 'spec/spec_helper'
require 'ostruct'
require 'app/contexts/photo_upload_context'

class FakeMetadataStore
  def initialize(metadata)
    @metadata = metadata
  end

  def get(id)
    @metadata[id]
  end
end

describe PhotoUploadContext do
  describe '#filename' do
    # it 'contains the filename' do
    #   context = PhotoUploadContext.new(OpenStruct.new(original_filename: 'foo.bar'), nil)
    #   context.call
    #   expect(context.filename).to eq 'foo.bar'
    # end
    it 'returns existing filename when duplicate' do
      store = mock
      store.expects(:get_by_hash).returns(OpenStruct.new(filename: 'test.jpg'))
      context = PhotoUploadContext.new(OpenStruct.new(original_filename: 'other.jpg', tempfile: 'spec/resources/one.txt'), store, nil)
      context.call
      expect(context.filename).to eq 'test.jpg'
    end
  end

  describe '#status' do
    it 'indicates when file is not photo' do
      context = PhotoUploadContext.new(OpenStruct.new(original_filename: 'foo.bar'), nil, nil)
      context.call
      expect(context.status).to eq 'file was not an allowed image type'
    end
    it 'indicates when file is a duplicate' do
      store = mock
      store.expects(:get_by_hash).returns(OpenStruct.new(filename: 'test.jpg'))
      context = PhotoUploadContext.new(OpenStruct.new(original_filename: 'other.jpg', tempfile: 'spec/resources/one.txt'), store, nil)
      context.call
      expect(context.status).to eq 'duplicate file'
    end
  end

  describe PhotoUploadContext::UploadedFileRole do
    describe '#filename' do
      it 'returns the original filename of a non-photo file' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(original_filename: 'foo.bar')
        expect(role.filename).to eq 'foo.bar'
      end
    end
    describe '#extension' do
      it 'returns the extension of the file' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(original_filename: 'foo.bar')
        expect(role.extension).to eq 'bar'
      end

      it 'lowercases the extension' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(original_filename: 'foo.BAR')
        expect(role.extension).to eq 'bar'
      end

      it 'caches the extension' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(original_filename: 'foo.BAR')
        expect(role.extension).to equal role.extension
      end

      it 'returns only the last extension' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(original_filename: 'foo.bar.baz')
        expect(role.extension).to eq 'baz'
      end
    end
    describe '#file_hash' do
      it 'returns an MD5 hash' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        expect(role.file_hash).to be
      end
      it 'caches the value' do
        role = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        expect(role.file_hash).to equal role.file_hash
      end
      it 'is different for different files' do
        role1 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        role2 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/two.txt')
        expect(role1.file_hash).not_to eq role2.file_hash
      end
      it 'is same for same file' do
        role1 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        role2 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        expect(role1.file_hash).to eq role2.file_hash
      end
      it 'is same for file with same contents' do
        role1 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one.txt')
        role2 = PhotoUploadContext::UploadedFileRole.new OpenStruct.new(tempfile: 'spec/resources/one_copy.txt')
        expect(role1.file_hash).to eq role2.file_hash
      end
    end
    context 'not a photo type' do
      subject { PhotoUploadContext::UploadedFileRole.new(OpenStruct.new(original_filename: 'foo.bar')) }
      it { should_not be_photo_type }
    end
    context 'jpg' do
      subject { PhotoUploadContext::UploadedFileRole.new(OpenStruct.new(original_filename: 'foo.jpg')) }
      it { should be_photo_type }
    end
    context 'jpeg' do
      subject { PhotoUploadContext::UploadedFileRole.new(OpenStruct.new(original_filename: 'foo.jpeg')) }
      it { should be_photo_type }
    end
    context 'png' do
      subject { PhotoUploadContext::UploadedFileRole.new(OpenStruct.new(original_filename: 'foo.png')) }
      it { should be_photo_type }
    end
    context 'gif' do
      subject { PhotoUploadContext::UploadedFileRole.new(OpenStruct.new(original_filename: 'foo.gif')) }
      it { should be_photo_type }
    end
  end
end