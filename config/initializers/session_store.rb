# Be sure to restart your server when you modify this file.

JpgRanger::Application.config.session_store :cookie_store, key: '_jpg-ranger_session'

Mongoid::Document.send(:include, ActiveModel::SerializerSupport)
Mongoid::Criteria.delegate(:active_model_serializer, to: :to_a)