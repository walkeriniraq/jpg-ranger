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
  describe '#call' do
    it 'returns existing photo when duplicate' do
      store = mock
      store.expects(:get_by_hash).returns('fake photo object')
      context = PhotoUploadContext.new(OpenStruct.new(original_filename: 'other.jpg', tempfile: 'spec/resources/one.txt'), store, nil)
      ret = context.call
      expect(ret[:status]).to eq 'duplicate file'
      expect(ret[:photos]).to eq 'fake photo object'
    end
  end

  describe PhotoUploadContext::UploadedFileRole do
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
    context 'not a photos type' do
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