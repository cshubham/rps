package org.rajawali3d.examples.examples.materials;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.support.annotation.Nullable;
import org.rajawali3d.Object3D;
import org.rajawali3d.examples.R;
import org.rajawali3d.examples.examples.AExampleFragment;
import org.rajawali3d.examples.examples.materials.materials.CustomRawFragmentShader;
import org.rajawali3d.examples.examples.materials.materials.CustomRawVertexShader;
import org.rajawali3d.lights.DirectionalLight;
import org.rajawali3d.materials.Material;
import org.rajawali3d.materials.shaders.FragmentShader;
import org.rajawali3d.materials.textures.ATexture;
import org.rajawali3d.materials.textures.Texture;
import org.rajawali3d.primitives.Plane;
import org.rajawali3d.primitives.Sphere;

public class RawShaderFilesFragment extends AExampleFragment {

	@Override
    public AExampleRenderer createRenderer() {
		return new RawShaderFilesRenderer(getActivity(), this);
	}

	public class RawShaderFilesRenderer extends AExampleRenderer {
		private DirectionalLight mLight;
		private Object3D mCube;
		private float mTime;
		private Material mMaterial;
		private CustomRawFragmentShader mCustomRawFragShader;

		public RawShaderFilesRenderer(Context context, @Nullable AExampleFragment fragment) {
			super(context, fragment);
		}

        @Override
		protected void initScene() {
			mLight = new DirectionalLight(0, 1, 1);

			getCurrentScene().addLight(mLight);

			mCustomRawFragShader = new CustomRawFragmentShader();
			mMaterial = new Material(new CustomRawVertexShader(), mCustomRawFragShader);
			mMaterial.enableTime(true);
			try {
				Texture texture = new Texture("myTex", R.drawable.xmas);

				BitmapFactory.Options options = new BitmapFactory.Options();
				options.inJustDecodeBounds = true;
				Bitmap bitmap = BitmapFactory.decodeResource(getResources(), R.drawable.happy, options);

				int width = options.outWidth; //bitmap.getWidth();
				int height = options.outHeight; //bitmap.getHeight();

				mCustomRawFragShader.setTexelSize(width, height);
				texture.setInfluence(.5f);
				mMaterial.addTexture(texture);
			} catch (ATexture.TextureException e) {
				e.printStackTrace();
			}
			mMaterial.setColorInfluence(.5f);
			mCube = new Plane();
			mCube.setScale(1.0, 1.6,1.0); // 9/16;
			mCube.setMaterial(mMaterial);
			getCurrentScene().addChild(mCube);

			getCurrentCamera().setPosition(0, 0, 1.9);

			mTime = 0;
		}

        @Override
        protected void onRender(long ellapsedRealtime, double deltaTime) {
            super.onRender(ellapsedRealtime, deltaTime);
			mTime += .007f;
			mMaterial.setTime(mTime);
		}
	}

}
